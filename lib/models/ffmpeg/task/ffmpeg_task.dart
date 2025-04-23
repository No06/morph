import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:logger/logger.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task_config.dart';
import 'package:morph/utils/ffmpeg/ffmpeg_runner.dart';
import 'package:morph/utils/ffmpeg/progress.dart';
import 'package:path/path.dart';

class FfmpegTask {
  FfmpegTask({
    required this.inputPath,
    required this.outputPath,
    required this.config,
  });

  final String inputPath;
  final String outputPath;
  final FfmpegTaskConfig config;

  final _listeners = <TaskListener>[];
  final _runner = FfmpegRunner();

  var _progress = Progress();
  Progress get progress => _progress;

  bool get isRunning => _runner.isRunning;

  var _isCompleted = false;
  bool get isCompleted => _isCompleted;

  FfmpegCommand toFfmpegCommand(String ffmpegPath) {
    return FfmpegCommand.complex(
      ffmpegPath: ffmpegPath,
      inputs: [FfmpegInput.asset(inputPath)],
      args: config.toFfmpegArgs(),
      filterGraph: null,
      outputFilepath:
          "$outputPath${config.commonArgs.format ?? extension(inputPath)}",
    );
  }

  Future<void> run({required String ffmpegPath}) async {
    if (isRunning) {
      Logger().w('FFmpeg 进程已启动，无法再次执行.');
      return;
    }

    _isCompleted = false;

    final command = toFfmpegCommand(ffmpegPath);
    return _runner.run(
      command: command,
      ffprobePath: ffmpegPath,
      inputPath: inputPath,
      onStdout: (stdout) {
        for (final listener in _listeners) {
          listener.onStdout(stdout);
        }
      },
      onStderr: (stderr) {
        for (final listener in _listeners) {
          listener.onStderr(stderr);
        }
      },
      onProgress: (progress) {
        _progress = progress;
        for (final listener in _listeners) {
          listener.onProgress(progress);
        }
      },
      onCompleted: (exitCode) {
        _isCompleted = true;
        for (final listener in _listeners) {
          listener.onCompleted(exitCode);
        }
      },
      onError: (error, stackTrace) {
        for (final listener in _listeners) {
          listener.onError(error, stackTrace);
        }
      },
    );
  }

  bool stop() {
    return _runner.stop();
  }

  void addListener(TaskListener listener) {
    _listeners.add(listener);
  }

  void removeListener(TaskListener listener) {
    _listeners.remove(listener);
  }
}

abstract mixin class TaskListener {
  void onStdout(String stdout) {}
  void onStderr(String stderr) {}
  void onProgress(Progress progress) {}
  void onCompleted(int exitCode) {}
  void onError(Object error, StackTrace stackTrace) {}
}
