import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/config/preference.dart';
import 'package:morph/models/json_map.dart';

part 'app_preference.g.dart';

class AppPreference extends PreferenceWithDefault<AppConfig> {
  AppPreference._()
    : super(
        "app",
        serialize: true,
        fromJson: AppConfig.fromJson,
        defaultValue: AppConfig(),
      );

  factory AppPreference() => instance;

  static final instance = AppPreference._();
}

@CopyWith()
@JsonSerializable()
class AppConfig {
  const AppConfig({this.ffmpegPath});

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  final String? ffmpegPath;

  JsonMap toJson() => _$AppConfigToJson(this);
}
