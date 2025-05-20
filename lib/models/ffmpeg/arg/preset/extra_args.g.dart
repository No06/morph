// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_args.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExtraArgsCWProxy {
  ExtraArgs extraArgs(List<CliArg>? extraArgs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExtraArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExtraArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  ExtraArgs call({List<CliArg>? extraArgs});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExtraArgs.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExtraArgs.copyWith.fieldName(...)`
class _$ExtraArgsCWProxyImpl implements _$ExtraArgsCWProxy {
  const _$ExtraArgsCWProxyImpl(this._value);

  final ExtraArgs _value;

  @override
  ExtraArgs extraArgs(List<CliArg>? extraArgs) => this(extraArgs: extraArgs);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExtraArgs(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExtraArgs(...).copyWith(id: 12, name: "My name")
  /// ````
  ExtraArgs call({Object? extraArgs = const $CopyWithPlaceholder()}) {
    return ExtraArgs(
      extraArgs:
          extraArgs == const $CopyWithPlaceholder()
              ? _value.extraArgs
              // ignore: cast_nullable_to_non_nullable
              : extraArgs as List<CliArg>?,
    );
  }
}

extension $ExtraArgsCopyWith on ExtraArgs {
  /// Returns a callable class that can be used as follows: `instanceOfExtraArgs.copyWith(...)` or like so:`instanceOfExtraArgs.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExtraArgsCWProxy get copyWith => _$ExtraArgsCWProxyImpl(this);
}

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
