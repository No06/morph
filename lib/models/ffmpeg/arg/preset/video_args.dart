import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/ffmpeg/arg/ffmpeg_args.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/json/cli_arg_json_converter.dart';

part 'video_args.g.dart';

@JsonEnum()
enum VideoEncoding {
  h264('h264'),
  h265('libx265'),
  vp9('libvpx-vp9');

  const VideoEncoding(this.value);

  final String value;
}

class Resolution {
  const Resolution(this.width, this.height);

  factory Resolution.fromJson(JsonMap json) =>
      Resolution.parse(json['resolution'] as String);

  factory Resolution.parse(String resolution) {
    final parts = resolution.split('x');
    if (parts.length != 2) {
      throw ArgumentError('Invalid resolution format: $resolution');
    }
    return Resolution(int.parse(parts[0]), int.parse(parts[1]));
  }

  final int width;
  final int height;

  /// 1920x1080
  static const p1080 = Resolution(1920, 1080);

  /// 1280x720
  static const p720 = Resolution(1280, 720);

  @override
  String toString() => "${width}x$height";

  JsonMap toJson() => {'resolution': toString()};
}

@JsonSerializable(converters: [CliArgJsonConverter()])
class VideoArgs extends FfmpegArgs {
  const VideoArgs({
    this.videoEncoding,
    this.resolution,
    this.frameRate,
    this.videoBitrate,
    super.extraArgs,
  });

  factory VideoArgs.fromJson(JsonMap json) => _$VideoArgsFromJson(json);

  final VideoEncoding? videoEncoding;
  final Resolution? resolution;
  final double? frameRate;
  final int? videoBitrate;

  JsonMap toJson() => _$VideoArgsToJson(this);

  @override
  List<CliArg> toCliArgs() {
    final args = <CliArg>[];

    if (videoEncoding != null) {
      args.add(CliArg(name: 'c:v', value: videoEncoding!.value));
    }

    if (resolution != null) {
      args.add(CliArg(name: 's', value: resolution.toString()));
    }

    if (frameRate != null) {
      args.add(CliArg(name: 'r', value: frameRate.toString()));
    }

    if (videoBitrate != null) {
      args.add(CliArg(name: 'b:v', value: '${videoBitrate}k'));
    }

    if (extraArgs?.isNotEmpty ?? false) {
      args.addAll(extraArgs!);
    }
    return args;
  }
}
