// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_args.dart';

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
