// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window_state_preference.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WindowStateCWProxy {
  WindowState position(Offset? position);

  WindowState size(Size? size);

  WindowState hideSystemTitleBar(bool? hideSystemTitleBar);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WindowState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WindowState(...).copyWith(id: 12, name: "My name")
  /// ````
  WindowState call({Offset? position, Size? size, bool? hideSystemTitleBar});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWindowState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWindowState.copyWith.fieldName(...)`
class _$WindowStateCWProxyImpl implements _$WindowStateCWProxy {
  const _$WindowStateCWProxyImpl(this._value);

  final WindowState _value;

  @override
  WindowState position(Offset? position) => this(position: position);

  @override
  WindowState size(Size? size) => this(size: size);

  @override
  WindowState hideSystemTitleBar(bool? hideSystemTitleBar) =>
      this(hideSystemTitleBar: hideSystemTitleBar);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WindowState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WindowState(...).copyWith(id: 12, name: "My name")
  /// ````
  WindowState call({
    Object? position = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
    Object? hideSystemTitleBar = const $CopyWithPlaceholder(),
  }) {
    return WindowState(
      position:
          position == const $CopyWithPlaceholder()
              ? _value.position
              // ignore: cast_nullable_to_non_nullable
              : position as Offset?,
      size:
          size == const $CopyWithPlaceholder()
              ? _value.size
              // ignore: cast_nullable_to_non_nullable
              : size as Size?,
      hideSystemTitleBar:
          hideSystemTitleBar == const $CopyWithPlaceholder()
              ? _value.hideSystemTitleBar
              // ignore: cast_nullable_to_non_nullable
              : hideSystemTitleBar as bool?,
    );
  }
}

extension $WindowStateCopyWith on WindowState {
  /// Returns a callable class that can be used as follows: `instanceOfWindowState.copyWith(...)` or like so:`instanceOfWindowState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WindowStateCWProxy get copyWith => _$WindowStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindowState _$WindowStateFromJson(Map<String, dynamic> json) => WindowState(
  position: _$JsonConverterFromJson<Map<String, dynamic>, Offset>(
    json['position'],
    const OffsetJsonConverter().fromJson,
  ),
  size: _$JsonConverterFromJson<Map<String, dynamic>, Size>(
    json['size'],
    const SizeJsonConverter().fromJson,
  ),
  hideSystemTitleBar: json['hideSystemTitleBar'] as bool?,
);

Map<String, dynamic> _$WindowStateToJson(WindowState instance) =>
    <String, dynamic>{
      'position': _$JsonConverterToJson<Map<String, dynamic>, Offset>(
        instance.position,
        const OffsetJsonConverter().toJson,
      ),
      'size': _$JsonConverterToJson<Map<String, dynamic>, Size>(
        instance.size,
        const SizeJsonConverter().toJson,
      ),
      'hideSystemTitleBar': instance.hideSystemTitleBar,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
