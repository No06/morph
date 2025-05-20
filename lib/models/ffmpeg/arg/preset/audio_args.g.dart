// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_args.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AudioArgsCWProxy {
  AudioArgs audioEnabled(bool audioEnabled);

  AudioArgs audioBitrate(int? audioBitrate);

  AudioArgs extraArgs(List<CliArg>? extraArgs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AudioArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AudioArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  AudioArgs call({
    bool audioEnabled,
    int? audioBitrate,
    List<CliArg>? extraArgs,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAudioArgs.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAudioArgs.copyWith.fieldName(...)`
class _$AudioArgsCWProxyImpl implements _$AudioArgsCWProxy {
  const _$AudioArgsCWProxyImpl(this._value);

  final AudioArgs _value;

  @override
  AudioArgs audioEnabled(bool audioEnabled) => this(audioEnabled: audioEnabled);

  @override
  AudioArgs audioBitrate(int? audioBitrate) => this(audioBitrate: audioBitrate);

  @override
  AudioArgs extraArgs(List<CliArg>? extraArgs) => this(extraArgs: extraArgs);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AudioArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AudioArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  AudioArgs call({
    Object? audioEnabled = const $CopyWithPlaceholder(),
    Object? audioBitrate = const $CopyWithPlaceholder(),
    Object? extraArgs = const $CopyWithPlaceholder(),
  }) {
    return AudioArgs(
      audioEnabled:
          audioEnabled == const $CopyWithPlaceholder()
              ? _value.audioEnabled
              // ignore: cast_nullable_to_non_nullable
              : audioEnabled as bool,
      audioBitrate:
          audioBitrate == const $CopyWithPlaceholder()
              ? _value.audioBitrate
              // ignore: cast_nullable_to_non_nullable
              : audioBitrate as int?,
      extraArgs:
          extraArgs == const $CopyWithPlaceholder()
              ? _value.extraArgs
              // ignore: cast_nullable_to_non_nullable
              : extraArgs as List<CliArg>?,
    );
  }
}

extension $AudioArgsCopyWith on AudioArgs {
  /// Returns a callable class that can be used as follows: `instanceOfAudioArgs.copyWith(...)` or like so:`instanceOfAudioArgs.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AudioArgsCWProxy get copyWith => _$AudioArgsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioArgs _$AudioArgsFromJson(Map<String, dynamic> json) => AudioArgs(
  audioEnabled: json['audioEnabled'] as bool? ?? true,
  audioBitrate: (json['audioBitrate'] as num?)?.toInt(),
  extraArgs:
      (json['extraArgs'] as List<dynamic>?)
          ?.map(
            (e) =>
                const CliArgJsonConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$AudioArgsToJson(AudioArgs instance) => <String, dynamic>{
  'extraArgs':
      instance.extraArgs?.map(const CliArgJsonConverter().toJson).toList(),
  'audioEnabled': instance.audioEnabled,
  'audioBitrate': instance.audioBitrate,
};
