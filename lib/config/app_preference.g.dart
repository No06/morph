// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preference.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppConfigCWProxy {
  AppConfig ffmpegPath(String? ffmpegPath);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppConfig(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppConfig(...).copyWith(id: 12, name: "My name")
  /// ````
  AppConfig call({String? ffmpegPath});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAppConfig.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAppConfig.copyWith.fieldName(...)`
class _$AppConfigCWProxyImpl implements _$AppConfigCWProxy {
  const _$AppConfigCWProxyImpl(this._value);

  final AppConfig _value;

  @override
  AppConfig ffmpegPath(String? ffmpegPath) => this(ffmpegPath: ffmpegPath);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppConfig(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppConfig(...).copyWith(id: 12, name: "My name")
  /// ````
  AppConfig call({Object? ffmpegPath = const $CopyWithPlaceholder()}) {
    return AppConfig(
      ffmpegPath:
          ffmpegPath == const $CopyWithPlaceholder()
              ? _value.ffmpegPath
              // ignore: cast_nullable_to_non_nullable
              : ffmpegPath as String?,
    );
  }
}

extension $AppConfigCopyWith on AppConfig {
  /// Returns a callable class that can be used as follows: `instanceOfAppConfig.copyWith(...)` or like so:`instanceOfAppConfig.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AppConfigCWProxy get copyWith => _$AppConfigCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) =>
    AppConfig(ffmpegPath: json['ffmpegPath'] as String?);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'ffmpegPath': instance.ffmpegPath,
};
