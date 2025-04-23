import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/ffmpeg/arg/ffmpeg_args.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/json/cli_arg_json_converter.dart';

part 'extra_args.g.dart';

@JsonSerializable(converters: [CliArgJsonConverter()])
class ExtraArgs extends FfmpegArgs {
  const ExtraArgs({super.extraArgs});

  factory ExtraArgs.fromJson(Map<String, dynamic> json) =>
      _$ExtraArgsFromJson(json);

  @override
  List<CliArg> toCliArgs() => extraArgs ?? [];

  JsonMap toJson() => _$ExtraArgsToJson(this);
}
