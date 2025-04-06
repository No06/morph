/// 表示从 FFmpeg stderr 解析出的单次进度更新。
class Progress {
  /// 当前处理的帧数。
  final int? frame;

  /// 当前处理速度（每秒帧数）。
  final double? fps;

  /// 量化参数（通常与视频质量相关）。
  /// 有些编码器（如 VBR）可能输出 N/A。
  final double? q;

  /// 当前已输出文件的大小（字节）。
  /// 注意：解析时需要处理 KiB, MiB 等单位并转换为字节。
  final int? sizeInBytes;

  /// 当前处理到的时间点。
  final Duration? time;

  /// 当前输出的比特率（千比特每秒 kbit/s）。
  /// 注意：解析时需要处理 kbits/s, mbits/s 等单位并转换为 kbit/s。
  final double? bitrateInKbitPerSec;

  /// 处理速度与实时速度的比率（例如 1.0x 表示实时，2.0x 表示两倍速）。
  final double? speed;

  /// 媒体文件的总时长（如果已知）。
  /// 计算百分比时需要。
  final Duration? totalDuration;

  const Progress({
    this.frame,
    this.fps,
    this.q,
    this.sizeInBytes,
    this.time,
    this.bitrateInKbitPerSec,
    this.speed,
    this.totalDuration,
  });

  /// 基于 [time] 和 [totalDuration] 计算进度百分比。
  /// 如果 [totalDuration] 或 [time] 为 null，或者 totalDuration 为零，则返回 null。
  double? get percentage {
    if (totalDuration != null &&
        totalDuration! > Duration.zero && // 检查总时长是否为正
        time != null) {
      final currentMicroseconds = time!.inMicroseconds;
      final totalMicroseconds = totalDuration!.inMicroseconds;

      // 避免除以零，并确保时间在逻辑上不超过总时长
      if (totalMicroseconds <= 0) {
        return null;
      }
      // 计算百分比并限制在 0.0 到 100.0 之间
      return (currentMicroseconds / totalMicroseconds * 100.0).clamp(
        0.0,
        100.0,
      );
    }
    return null; // 无法计算百分比
  }
}
