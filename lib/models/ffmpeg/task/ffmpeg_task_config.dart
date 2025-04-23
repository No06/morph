import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/ffmpeg/arg/preset/audio_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/common_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/extra_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/video_args.dart';
import 'package:morph/models/json_map.dart';

part 'ffmpeg_task_config.g.dart';

@JsonSerializable()
class FfmpegTaskConfig {
  const FfmpegTaskConfig({
    required this.name,
    required this.audioArgs,
    required this.commonArgs,
    required this.videoArgs,
    this.extraArgs,
  });

  factory FfmpegTaskConfig.fromJson(Map<String, dynamic> json) =>
      _$FfmpegTaskConfigFromJson(json);

  final String name;
  final CommonArgs commonArgs;
  final VideoArgs videoArgs;
  final AudioArgs audioArgs;
  final ExtraArgs? extraArgs;

  List<CliArg> toFfmpegArgs() {
    final args = <CliArg>[];

    args.addAll(commonArgs.toCliArgs());
    args.addAll(videoArgs.toCliArgs());
    args.addAll(audioArgs.toCliArgs());

    return args;
  }

  JsonMap toJson() => _$FfmpegTaskConfigToJson(this);
}
