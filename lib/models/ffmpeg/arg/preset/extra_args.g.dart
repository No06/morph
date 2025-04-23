// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_args.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraArgs _$ExtraArgsFromJson(Map<String, dynamic> json) => ExtraArgs(
  extraArgs:
      (json['extraArgs'] as List<dynamic>?)
          ?.map(
            (e) =>
                const CliArgJsonConverter().fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$ExtraArgsToJson(ExtraArgs instance) => <String, dynamic>{
  'extraArgs':
      instance.extraArgs?.map(const CliArgJsonConverter().toJson).toList(),
};
