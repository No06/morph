import 'dart:convert';
import 'dart:io';

import 'package:ffmpeg_cli/ffmpeg_cli.dart';

class Ffprobe {
  /// Runs the FFMPEG `ffprobe` CLI command against the given [filepath].
  static Future<FfprobeResult> run(String ffprobePath, String filepath) async {
    final result = await Process.run(ffprobePath, [
      '-v',
      'quiet',
      '-print_format',
      'json',
      '-show_format',
      '-show_streams',
      filepath,
    ]);

    if (result.exitCode != 0) {
      print('Failed to run ffprobe for "$filepath"');
      throw Exception(
        'ffprobe returned error: ${result.exitCode}\n${result.stderr}',
      );
    }

    if (result.stdout == null ||
        result.stdout is! String ||
        (result.stdout as String).isEmpty) {
      throw Exception('ffprobe did not output expected data: ${result.stdout}');
    }

    final json = jsonDecode(result.stdout);
    return FfprobeResult.fromJson(json);
  }
}
