import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:morph/app.dart';
import 'package:morph/config/window_state_preference.dart';
import 'package:morph/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    WindowStatePreference().init(sharedPreferences);
  }

  initWindow() async {
    await windowManager.ensureInitialized();
    const defaultWindowSize = Size(960, 593);
    final windowState = WindowStatePreference().value;
    final windowSize = windowState?.size ?? defaultWindowSize;
    final position = windowState?.position;
    final hasPosition = position != null;
    final hideSystemTitleBar = windowState?.hideSystemTitleBar ?? false;
    final windowOptions = WindowOptions(
      center: !hasPosition,
      size: windowSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle:
          hideSystemTitleBar ? TitleBarStyle.hidden : TitleBarStyle.normal,
    );
    windowManager.addListener(WindowStateListener());
    return windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (hasPosition) await windowManager.setPosition(position);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  await initPreferences();
  await LocaleSettings.useDeviceLocale();
  await initWindow();

  runApp(ProviderScope(child: TranslationProvider(child: const MyApp())));
}
