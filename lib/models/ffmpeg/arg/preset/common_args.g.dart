// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_args.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommonArgsCWProxy {
  CommonArgs format(String? format);

  CommonArgs extraArgs(List<CliArg>? extraArgs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommonArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommonArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  CommonArgs call({String? format, List<CliArg>? extraArgs});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommonArgs.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommonArgs.copyWith.fieldName(...)`
class _$CommonArgsCWProxyImpl implements _$CommonArgsCWProxy {
  const _$CommonArgsCWProxyImpl(this._value);

  final CommonArgs _value;

  @override
  CommonArgs format(String? format) => this(format: format);

  @override
  CommonArgs extraArgs(List<CliArg>? extraArgs) => this(extraArgs: extraArgs);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CommonArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CommonArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  CommonArgs call({
    Object? format = const $CopyWithPlaceholder(),
    Object? extraArgs = const $CopyWithPlaceholder(),
  }) {
    return CommonArgs(
      format:
          format == const $CopyWithPlaceholder()
              ? _value.format
              // ignore: cast_nullable_to_non_nullable
              : format as String?,
      extraArgs:
          extraArgs == const $CopyWithPlaceholder()
              ? _value.extraArgs
              // ignore: cast_nullable_to_non_nullable
              : extraArgs as List<CliArg>?,
    );
  }
}

extension $CommonArgsCopyWith on CommonArgs {
  /// Returns a callable class that can be used as follows: `instanceOfCommonArgs.copyWith(...)` or like so:`instanceOfCommonArgs.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommonArgsCWProxy get copyWith => _$CommonArgsCWProxyImpl(this);
}

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
