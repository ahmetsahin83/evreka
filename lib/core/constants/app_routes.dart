import '../../pages/_app_exports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String initialLocation = "/";
final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) => const OperationView(),
    ),
  ],
);
