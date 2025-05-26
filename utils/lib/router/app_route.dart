import 'package:go_router/go_router.dart';

abstract class AppRoute {
  int get index;
  final String path;
  final String name;

  const AppRoute({required this.path, required this.name});

  RouteBase get route;
}
