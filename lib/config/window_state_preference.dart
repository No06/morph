import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:morph/config/preference.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/debouncer.dart';
import 'package:morph/utils/json/offset_json_converter.dart';
import 'package:morph/utils/json/size_json_converter.dart';
import 'package:window_manager/window_manager.dart';

part 'window_state_preference.g.dart';

class WindowStatePreference extends PreferenceWithDefault<WindowState> {
  WindowStatePreference._()
    : super(
        "windowState",
        serialize: true,
        fromJson: WindowState.fromJson,
        defaultValue: WindowState(
          position: null,
          size: Size(960, 593),
          hideSystemTitleBar: !kIsWeb && Platform.isWindows,
        ),
      );

  factory WindowStatePreference() => instance;

  static final instance = WindowStatePreference._();
}

@JsonSerializable()
@CopyWith()
class WindowState {
  const WindowState({
    this.position,
    this.size,
    required this.hideSystemTitleBar,
  });

  factory WindowState.fromJson(JsonMap json) => _$WindowStateFromJson(json);

  @OffsetJsonConverter()
  final Offset? position;

  @SizeJsonConverter()
  final Size? size;

  final bool hideSystemTitleBar;

  JsonMap toJson() => _$WindowStateToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class WindowStateListener extends WindowListener {
  late final _debouncer = Debouncer(const Duration(milliseconds: 500));

  void _updateState() async {
    final windowState = WindowStatePreference().value;
    final position = await windowManager.getPosition();
    final size = await windowManager.getSize();
    WindowStatePreference().value = windowState.copyWith(
      position: position,
      size: size,
    );
  }

  void _updateStateDebounced() => _debouncer.run(_updateState);

  /// Unavaliabe on Linux
  @override
  void onWindowMoved() => _updateState();

  /// Unavaliabe on Linux
  @override
  void onWindowResized() => _updateState();

  @override
  void onWindowMove() {
    if (Platform.isLinux) {
      _updateStateDebounced();
    }
  }

  @override
  void onWindowResize() {
    if (Platform.isLinux) {
      _updateStateDebounced();
    }
  }
}
