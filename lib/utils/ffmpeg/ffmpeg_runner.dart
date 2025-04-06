import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:morph/utils/ffmpeg/progress.dart';

/// 一个封装并运行 FfmpegCommand 并提供底层流和进度回调的类。
/// 这个版本直接使用 `Ffmpeg().run()` 并处理 `dart:io Process`。
class FfmpegRunner {
  /// 要执行的 FFmpeg 命令配置。
  final FfmpegCommand command;

  /// 创建一个 FFmpegRunner 实例。
  ///
  /// 需要一个 [FfmpegCommand] 实例，该实例定义了 FFmpeg 操作。
  const FfmpegRunner(this.command);

  Progress? _tryParseProgress(String line, Duration? totalDuration) {
    // 添加了 totalDuration 参数
    if (!line.contains('frame=') || !line.contains('time=')) {
      return null;
    }
    int? frame;
    double? fps;
    double? q;
    int? sizeInBytes;
    Duration? time;
    double? bitrateInKbitPerSec;
    double? speed;
    final pattern = RegExp(r'(\w+)=\s*(-?\S+)');
    final matches = pattern.allMatches(line);
    for (final match in matches) {
      final key = match.group(1);
      final value = match.group(2)?.trim();
      if (value == null || value.isEmpty) continue;
      try {
        switch (key) {
          case 'frame':
            frame = int.tryParse(value);
            break;
          case 'fps':
            fps = double.tryParse(value);
            break;
          case 'q':
            if (value != 'N/A') {
              q = double.tryParse(value);
            }
            break;
          case 'size':
            sizeInBytes = _parseSize(value);
            break;
          case 'time':
            time = _parseDuration(value);
            break;
          case 'bitrate':
            if (value.toLowerCase() != 'n/a') {
              bitrateInKbitPerSec = _parseBitrate(value);
            }
            break;
          case 'speed':
            if (value.endsWith('x')) {
              speed = double.tryParse(value.substring(0, value.length - 1));
            }
            break;
        }
      } catch (e) {
        /* print("解析字段 '$key' 的值 '$value' 时出错: $e"); */
      }
    }
    if (frame != null || time != null) {
      // 在创建 Progress 对象时传入 totalDuration
      return Progress(
        frame: frame,
        fps: fps,
        q: q,
        sizeInBytes: sizeInBytes,
        time: time,
        bitrateInKbitPerSec: bitrateInKbitPerSec,
        speed: speed,
        totalDuration: totalDuration, // 传递 totalDuration
      );
    }
    return null;
  }

  // --- 需要添加的辅助解析函数 ---

  // 解析 HH:MM:SS.ms 格式的时间字符串为 Duration (这个之前已经有了)
  Duration? _parseDuration(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length != 3) return null;
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);
      final secondsParts = parts[2].split('.');
      final seconds = int.parse(secondsParts[0]);
      // 支持小数秒部分，可能不止两位
      final microsecondPart = (secondsParts.length > 1) ? secondsParts[1] : '0';
      // 确保微秒部分是6位数
      final microseconds = int.parse(
        microsecondPart.padRight(6, '0').substring(0, 6),
      );

      return Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        microseconds: microseconds,
      );
    } catch (e) {
      // print("无法解析时间字符串: $timeStr, 错误: $e");
      return null;
    }
  }

  // 解析大小字符串 (例如 "768KiB", "1.5MiB", "1024B") 为字节
  int? _parseSize(String sizeStr) {
    if (sizeStr.toLowerCase() == 'n/a') return null;

    final sizeLower = sizeStr.toLowerCase();
    double multiplier = 1.0;

    if (sizeLower.endsWith('kib')) {
      multiplier = 1024.0;
    } else if (sizeLower.endsWith('mib')) {
      multiplier = 1024.0 * 1024.0;
    } else if (sizeLower.endsWith('gib')) {
      multiplier = 1024.0 * 1024.0 * 1024.0;
    } else if (sizeLower.endsWith('kb')) {
      // 有时可能是 KB (1000) 而不是 KiB (1024)
      multiplier = 1000.0; // FFmpeg 通常用 KiB，但以防万一
    } else if (sizeLower.endsWith('mb')) {
      multiplier = 1000.0 * 1000.0;
    } // 可以继续添加 GiB, TiB 等

    // 移除单位后缀
    final numberPart = sizeLower.replaceAll(RegExp(r'[a-z/]+$'), '');
    final value = double.tryParse(numberPart);

    if (value != null) {
      return (value * multiplier).round(); // 转换为整数字节
    }
    return null;
  }

  // 解析比特率字符串 (例如 "426.6kbits/s") 为 kbit/s
  double? _parseBitrate(String bitrateStr) {
    if (bitrateStr.toLowerCase() == 'n/a') return null;

    final bitrateLower = bitrateStr.toLowerCase();
    double multiplier = 1.0; // 默认为 kbit/s

    if (bitrateLower.contains('mbits')) {
      multiplier = 1000.0; // mbit -> kbit
    } else if (bitrateLower.contains('bits')) {
      // 如果是纯 bits/s (不常见，但可能)
      if (!bitrateLower.contains('kbits') && !bitrateLower.contains('mbits')) {
        multiplier = 1.0 / 1000.0; // bit -> kbit
      }
    } // 可以添加 Gbits 等

    // 移除非数字和小数点的部分
    final numberPart = bitrateLower.replaceAll(RegExp(r'[^\d.]'), '');
    final value = double.tryParse(numberPart);

    if (value != null) {
      return value * multiplier;
    }
    return null;
  }

  /// 执行配置好的 FFmpeg 命令。
  ///
  /// - [onStdout]: 标准输出回调。
  /// - [onStderr]: 标准错误回调。
  /// - [onProgress]: 进度回调，接收包含百分比 getter 的 Progress 对象。
  /// - [onCompleted]: 完成回调。
  /// - [onError]: 错误回调。
  Future<void> run({
    required String ffprobePath,
    required String inputPath,
    void Function(String line)? onStdout,
    void Function(String line)? onStderr,
    void Function(Progress progress)? onProgress, // 回调签名恢复
    void Function(int exitCode)? onCompleted,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    print('准备执行 FFmpeg 命令...');
    Process? process;
    Duration? totalMediaDuration; // 存储为 Duration 类型

    try {
      // --- 1. 获取视频总时长 ---
      if (command.inputs.isNotEmpty) {
        print('尝试使用 ffprobe 获取 "$inputPath" 的时长...');
        try {
          final probeResult = await Ffprobe.run(inputPath);
          final format = probeResult.format;
          if (format == null) {
            print('ffprobe 未能返回格式信息.');
            return;
          }
          totalMediaDuration = format.duration;
          if (totalMediaDuration == null) {
            print('ffprobe 未能获取时长信息.');
          } else {
            print('获取到时长: $totalMediaDuration');
          }
        } catch (e, s) {
          print('运行 ffprobe 获取时长时出错: $e');
          onError?.call(e, s); // 可选：转发错误
        }
      } else {
        print('警告: 命令中未找到输入文件，无法获取时长。');
      }

      // --- 2. 执行 FFmpeg 命令 ---
      print('开始执行 FFmpeg...');
      process = await Ffmpeg().run(command);
      print('FFmpeg 进程已启动 (PID: ${process.pid}).');

      final stdoutCompleter = Completer<void>();
      final stderrCompleter = Completer<void>();

      // --- 3. 监听流 ---
      // stdout 监听器保持不变
      process.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
            (line) => onStdout?.call(line),
            onError: (e, s) {
              if (!stdoutCompleter.isCompleted) {
                stdoutCompleter.completeError(e, s);
              }
              if (!stderrCompleter.isCompleted) {
                stderrCompleter.complete();
              }
              onError?.call(e, s);
            },
            onDone: () {
              if (!stdoutCompleter.isCompleted) stdoutCompleter.complete();
            },
            cancelOnError: true,
          );

      // stderr 监听器: 将 totalMediaDuration 传递给 _tryParseProgress
      process.stderr
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
            (line) {
              onStderr?.call(line);
              // 解析时传递 totalMediaDuration
              final progress = _tryParseProgress(line, totalMediaDuration);
              if (progress != null) {
                // 使用包含 getter 的 Progress 对象调用 onProgress
                onProgress?.call(progress);
              }
            },
            onError: (e, s) {
              if (!stderrCompleter.isCompleted) {
                stderrCompleter.completeError(e, s);
              }
              if (!stdoutCompleter.isCompleted) {
                stdoutCompleter.complete();
              }
              onError?.call(e, s);
            },
            onDone: () {
              if (!stderrCompleter.isCompleted) {
                stderrCompleter.complete();
              }
            },
            cancelOnError: true,
          );

      // --- 4. 等待进程退出 ---
      final exitCode = await process.exitCode;
      print('FFmpeg 进程已退出，退出代码: $exitCode.');

      // --- 5. 调用完成回调 ---
      // 可选：在成功完成时触发一个最终的进度更新，确保达到 100%
      if (exitCode == 0 && totalMediaDuration != null && onProgress != null) {
        // 创建一个最终的 Progress 对象，时间等于总时长
        final finalProgress = Progress(
          time: totalMediaDuration,
          totalDuration: totalMediaDuration,
          // 如果知道最终大小等信息，也可以在这里添加
        );
        onProgress(finalProgress); // percentage getter 会计算出 100.0
      }
      onCompleted?.call(exitCode);
    } catch (e, s) {
      print('执行 FFmpeg 或前置操作时捕获到错误: $e');
      onError?.call(e, s);
    }
  }
}
