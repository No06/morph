import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/ffmpeg/arg/ffmpeg_args.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/json/cli_arg_json_converter.dart';

part 'audio_args.g.dart';

@JsonSerializable(converters: [CliArgJsonConverter()])
@CopyWith()
class AudioArgs extends FfmpegArgs {
  const AudioArgs({
    this.audioEnabled = true,
    this.audioBitrate,
    super.extraArgs,
  });

  factory AudioArgs.fromJson(JsonMap json) => _$AudioArgsFromJson(json);

  final bool audioEnabled;
  final int? audioBitrate;

  @override
  List<CliArg> toCliArgs() {
    final args = <CliArg>[];

    if (!audioEnabled) {
      args.add(CliArg(name: 'an'));
    } else {
      if (audioBitrate != null) {
        args.add(CliArg(name: 'b:a', value: audioBitrate.toString()));
      }
    }

    if (extraArgs?.isNotEmpty ?? false) {
      args.addAll(extraArgs!);
    }

    return args;
  }

  JsonMap toJson() => _$AudioArgsToJson(this);
}
