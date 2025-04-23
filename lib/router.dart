part of 'app.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final mainPageNavigatorKey = GlobalKey<NavigatorState>();
final convertPageNavigatorKey = GlobalKey<NavigatorState>();

GlobalKey<NavigatorState> get windowBodyNavigatorKey =>
    WindowStatePreference().value.hideSystemTitleBar
        ? mainPageNavigatorKey
        : convertPageNavigatorKey;

final _routerProvider = Provider<GoRouter>((ref) {
  final routes = <RouteBase>[];
  final convertPageRoute = ShellRoute(
    navigatorKey: convertPageNavigatorKey,
    builder: (context, state, child) => _MainPage(child: child),
    routes: [
      GoRoute(
        path: '/convert',
        pageBuilder:
            (context, state) =>
                _SharedAxisPage(key: state.pageKey, child: const ConvertPage()),
      ),
      GoRoute(
        path: '/setting',
        pageBuilder:
            (context, state) => _SharedAxisPage(
              key: state.pageKey,
              child: const SettingsPage(),
            ),
      ),
      GoRoute(
        path: '/debug',
        pageBuilder: (context, state) {
          return _SharedAxisPage(key: state.pageKey, child: const DebugPage());
        },
      ),
    ],
  );
  if (WindowStatePreference().value.hideSystemTitleBar) {
    routes.add(
      ShellRoute(
        navigatorKey: mainPageNavigatorKey,
        routes: [convertPageRoute],
        builder: (context, state, child) => VirtualWindowFrame(body: child),
      ),
    );
  } else {
    routes.add(convertPageRoute);
  }

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/convert',
    routes: routes,
  );
});

class _RouteInformationNotifier extends ChangeNotifier {
  _RouteInformationNotifier(this.routeInformationProvider) {
    routeInformationProvider.addListener(notifyListeners);
  }
  final RouteInformationProvider routeInformationProvider;

  @override
  void dispose() {
    routeInformationProvider.removeListener(notifyListeners);
    super.dispose();
  }
}

final _routeInformationNotifierProvider =
    ChangeNotifierProvider<_RouteInformationNotifier>((ref) {
      final goRouter = ref.watch(_routerProvider);
      return _RouteInformationNotifier(goRouter.routeInformationProvider);
    });

class _SharedAxisPage<T> extends Page<T> {
  const _SharedAxisPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder:
          (context, animation, secondaryAnimation) => SharedAxisTransition(
            transitionType: SharedAxisTransitionType.vertical,
            fillColor: const Color.fromRGBO(0, 0, 0, 0),
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 0.1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}

extension BuildContextExtension on BuildContext {
  Future<T?> appPush<T>(
    Widget page, {
    PageTransitionType type = PageTransitionType.rightToLeft,
  }) => pushTransition<T>(
    type: type,
    curve: Curves.fastEaseInToSlowEaseOut,
    duration: const Duration(milliseconds: 335),
    child: DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 35)],
      ),
      child: page,
    ),
  );
}
