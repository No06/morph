// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_args.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonArgs _$CommonArgsFromJson(Map<String, dynamic> json) => CommonArgs(
  format: json['format'] as String?,
  extraArgs:
      (json['extraArgs'] as List<dynamic>?)
          ?.map(
            (e) =>
                const CliArgJsonConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$CommonArgsToJson(CommonArgs instance) =>
    <String, dynamic>{
      'extraArgs':
          instance.extraArgs?.map(const CliArgJsonConverter().toJson).toList(),
      'format': instance.format,
    };
