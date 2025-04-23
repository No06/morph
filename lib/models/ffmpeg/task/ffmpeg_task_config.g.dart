// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ffmpeg_task_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FfmpegTaskConfig _$FfmpegTaskConfigFromJson(Map<String, dynamic> json) =>
    FfmpegTaskConfig(
      name: json['name'] as String,
      audioArgs: AudioArgs.fromJson(json['audioArgs'] as Map<String, dynamic>),
      commonArgs: CommonArgs.fromJson(
        json['commonArgs'] as Map<String, dynamic>,
      ),
      videoArgs: VideoArgs.fromJson(json['videoArgs'] as Map<String, dynamic>),
      extraArgs:
          json['extraArgs'] == null
              ? null
              : ExtraArgs.fromJson(json['extraArgs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FfmpegTaskConfigToJson(FfmpegTaskConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'commonArgs': instance.commonArgs,
      'videoArgs': instance.videoArgs,
      'audioArgs': instance.audioArgs,
      'extraArgs': instance.extraArgs,
    };
