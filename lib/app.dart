import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:morph/config/window_state_preference.dart';
import 'package:morph/i18n/strings.g.dart';
import 'package:morph/pages/run/run_page.dart';
import 'package:morph/pages/debug_page.dart';
import 'package:morph/pages/settings_page.dart';
import 'package:morph/widgets/virtual_window_frame.dart';
import 'package:page_transition/page_transition.dart';

part 'router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      locale: TranslationProvider.of(context).flutterLocale, // use provider
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              children: [
                const _Navigation(),
                Expanded(
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.surface,
                    child: SizedBox.expand(child: child),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Navigation extends HookWidget {
  const _Navigation();

  @override
  Widget build(BuildContext context) {
    final navigationIndex = useState(0);
    final t = Translations.of(context);
    return NavigationRail(
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.change_circle_outlined),
          selectedIcon: Icon(Icons.change_circle),
          label: Text(t.mainPage.navigation.convert),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text(t.mainPage.navigation.settings),
        ),
        if (kDebugMode)
          NavigationRailDestination(
            icon: Icon(Icons.bug_report_outlined),
            selectedIcon: Icon(Icons.bug_report),
            label: Text(t.mainPage.navigation.debug),
          ),
      ],
      groupAlignment: 0,
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: (index) {
        navigationIndex.value = index;
        context.go(switch (index) {
          0 => '/convert',
          1 => '/setting',
          2 => '/debug',
          _ => throw Exception('Invalid index: $index'),
        });
      },
      selectedIndex: navigationIndex.value,
    );
  }
}
