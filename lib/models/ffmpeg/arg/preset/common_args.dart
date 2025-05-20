import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/ffmpeg/arg/ffmpeg_args.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/json/cli_arg_json_converter.dart';

part 'common_args.g.dart';

@JsonSerializable(converters: [CliArgJsonConverter()])
@CopyWith()
class CommonArgs extends FfmpegArgs {
  const CommonArgs({this.format, super.extraArgs});

  factory CommonArgs.fromJson(Map<String, dynamic> json) =>
      _$CommonArgsFromJson(json);

  final String? format;

  @override
  List<CliArg> toCliArgs() => [];

  JsonMap toJson() => _$CommonArgsToJson(this);
}
