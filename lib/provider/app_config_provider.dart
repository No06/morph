import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:morph/config/app_preference.dart';

class AppConfigNotifier extends StateNotifier<AppConfig> {
  AppConfigNotifier() : super(AppPreference().value);

  set ffmpegPath(String? path) {
    state = state.copyWith(ffmpegPath: path);
  }
}

final appConfigProvider = StateNotifierProvider<AppConfigNotifier, AppConfig>((
  ref,
) {
  return AppConfigNotifier();
});
