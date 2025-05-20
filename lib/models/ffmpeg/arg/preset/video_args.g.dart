// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_args.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VideoArgsCWProxy {
  VideoArgs videoEncoding(VideoEncoding? videoEncoding);

  VideoArgs resolution(Resolution? resolution);

  VideoArgs frameRate(double? frameRate);

  VideoArgs videoBitrate(int? videoBitrate);

  VideoArgs extraArgs(List<CliArg>? extraArgs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VideoArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VideoArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  VideoArgs call({
    VideoEncoding? videoEncoding,
    Resolution? resolution,
    double? frameRate,
    int? videoBitrate,
    List<CliArg>? extraArgs,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVideoArgs.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVideoArgs.copyWith.fieldName(...)`
class _$VideoArgsCWProxyImpl implements _$VideoArgsCWProxy {
  const _$VideoArgsCWProxyImpl(this._value);

  final VideoArgs _value;

  @override
  VideoArgs videoEncoding(VideoEncoding? videoEncoding) =>
      this(videoEncoding: videoEncoding);

  @override
  VideoArgs resolution(Resolution? resolution) => this(resolution: resolution);

  @override
  VideoArgs frameRate(double? frameRate) => this(frameRate: frameRate);

  @override
  VideoArgs videoBitrate(int? videoBitrate) => this(videoBitrate: videoBitrate);

  @override
  VideoArgs extraArgs(List<CliArg>? extraArgs) => this(extraArgs: extraArgs);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VideoArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VideoArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  VideoArgs call({
    Object? videoEncoding = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? frameRate = const $CopyWithPlaceholder(),
    Object? videoBitrate = const $CopyWithPlaceholder(),
    Object? extraArgs = const $CopyWithPlaceholder(),
  }) {
    return VideoArgs(
      videoEncoding:
          videoEncoding == const $CopyWithPlaceholder()
              ? _value.videoEncoding
              // ignore: cast_nullable_to_non_nullable
              : videoEncoding as VideoEncoding?,
      resolution:
          resolution == const $CopyWithPlaceholder()
              ? _value.resolution
              // ignore: cast_nullable_to_non_nullable
              : resolution as Resolution?,
      frameRate:
          frameRate == const $CopyWithPlaceholder()
              ? _value.frameRate
              // ignore: cast_nullable_to_non_nullable
              : frameRate as double?,
      videoBitrate:
          videoBitrate == const $CopyWithPlaceholder()
              ? _value.videoBitrate
              // ignore: cast_nullable_to_non_nullable
              : videoBitrate as int?,
      extraArgs:
          extraArgs == const $CopyWithPlaceholder()
              ? _value.extraArgs
              // ignore: cast_nullable_to_non_nullable
              : extraArgs as List<CliArg>?,
    );
  }
}

extension $VideoArgsCopyWith on VideoArgs {
  /// Returns a callable class that can be used as follows: `instanceOfVideoArgs.copyWith(...)` or like so:`instanceOfVideoArgs.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VideoArgsCWProxy get copyWith => _$VideoArgsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoArgs _$VideoArgsFromJson(Map<String, dynamic> json) => VideoArgs(
  videoEncoding: $enumDecodeNullable(
    _$VideoEncodingEnumMap,
    json['videoEncoding'],
  ),
  resolution:
      json['resolution'] == null
          ? null
          : Resolution.fromJson(json['resolution'] as Map<String, dynamic>),
  frameRate: (json['frameRate'] as num?)?.toDouble(),
  videoBitrate: (json['videoBitrate'] as num?)?.toInt(),
  extraArgs:
      (json['extraArgs'] as List<dynamic>?)
          ?.map(
            (e) =>
                const CliArgJsonConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$VideoArgsToJson(VideoArgs instance) => <String, dynamic>{
  'extraArgs':
      instance.extraArgs?.map(const CliArgJsonConverter().toJson).toList(),
  'videoEncoding': _$VideoEncodingEnumMap[instance.videoEncoding],
  'resolution': instance.resolution,
  'frameRate': instance.frameRate,
  'videoBitrate': instance.videoBitrate,
};

const _$VideoEncodingEnumMap = {
  VideoEncoding.h264: 'h264',
  VideoEncoding.h265: 'h265',
  VideoEncoding.vp9: 'vp9',
};
