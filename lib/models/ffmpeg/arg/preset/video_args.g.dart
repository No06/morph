// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_args.dart';

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
