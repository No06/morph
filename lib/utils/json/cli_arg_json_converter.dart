import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/models/json_map.dart';

class CliArgJsonConverter extends JsonConverter<CliArg, JsonMap> {
  const CliArgJsonConverter();

  @override
  CliArg fromJson(JsonMap json) =>
      CliArg(name: json['name'] as String, value: json['value'] as String?);

  @override
  JsonMap toJson(CliArg object) => {'name': object.name, 'value': object.value};
}
