import 'package:ffmpeg_cli/ffmpeg_cli.dart';

abstract class FfmpegArgs {
  const FfmpegArgs({this.extraArgs});

  final List<CliArg>? extraArgs;

  List<CliArg> toCliArgs();
}
