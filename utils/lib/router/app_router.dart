import 'package:utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

abstract class AppRouter {
  final navigatorKey = GlobalKey<NavigatorState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  Future<String> getInitialLocation();
  List<RouteBase> get routes;

  Future<GoRouter> initialize() async {
    final initialLocation = await getInitialLocation();

    return GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: initialLocation,
      routes: routes,
    );
  }

  void goTo({required AppRoute route, Object? parameters}) {
    navigatorKey.currentState?.context.go(route.path, extra: parameters);
  }

  Future<T?> push<T extends Object?>({
    required AppRoute route,
    Object? parameters,
  }) async {
    return await navigatorKey.currentState?.context.push(
      route.path,
      extra: parameters,
    );
  }

  void pop<T extends Object>([T? result]) {
    return navigatorKey.currentState?.context.pop(result);
  }
}
