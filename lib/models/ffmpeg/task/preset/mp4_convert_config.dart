import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/ffmpeg/arg/preset/audio_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/common_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/extra_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/video_args.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task_config.dart';
import 'package:morph/models/json_map.dart';

part 'mp4_convert_config.g.dart';

@JsonSerializable()
class Mp4ConvertConfig extends FfmpegTaskConfig {
  const Mp4ConvertConfig()
    : super(
        name: "MP4",
        audioArgs: const AudioArgs(),
        commonArgs: const CommonArgs(format: "mp4"),
        videoArgs: const VideoArgs(),
        extraArgs: const ExtraArgs(),
      );

  factory Mp4ConvertConfig.fromJson(Map<String, dynamic> json) =>
      _$Mp4ConvertConfigFromJson(json);

  @override
  JsonMap toJson() => _$Mp4ConvertConfigToJson(this);
}
