import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utils/utils.dart';

void main() {
  group('AppRouter', () {
    late TestAppRouter appRouter;

    setUp(() {
      appRouter = TestAppRouter(
        testInitialLocation: '/mock',
        testRoutes: [MockAppRoute.mock.route, MockAppRoute.mock2.route],
      );
    });

    testWidgets('goTo calls navigator go with correct path and params', (
      tester,
    ) async {
      final router = await appRouter.initialize();

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          scaffoldMessengerKey: appRouter.scaffoldKey,
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Screen: mock'), findsOneWidget);

      appRouter.goTo(route: MockAppRoute.mock2, parameters: {'key': 'value'});
      await tester.pumpAndSettle();

      expect(find.text('Screen: mock2'), findsOneWidget);
    });

    testWidgets('push pushes to correct route and returns result with pop', (
      tester,
    ) async {
      final router = await appRouter.initialize();
      Object? returned;

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
          scaffoldMessengerKey: appRouter.scaffoldKey,
        ),
      );

      final future = appRouter.push(route: MockAppRoute.mock2);

      await tester.pumpAndSettle();
      expect(find.text('Screen: mock2'), findsOneWidget);

      await tester.tap(find.text('Pop'));
      await tester.pumpAndSettle();

      returned = await future;

      expect(returned, equals('result-from-mock2'));
      expect(find.text('Screen: mock'), findsOneWidget);
    });
  });
}

// -----------------------------
// MOCK SETUP
// -----------------------------
enum MockAppRoute implements AppRoute {
  mock(path: '/mock', name: 'mock'),
  mock2(path: '/mock-2', name: 'mock2');

  @override
  final String path;
  @override
  final String name;

  const MockAppRoute({required this.path, required this.name});

  @override
  RouteBase get route => GoRoute(
    path: path,
    name: name,
    pageBuilder:
        (context, state) =>
            MaterialPage(key: state.pageKey, child: _MockScreen(name: name)),
  );
}

class _MockScreen extends StatelessWidget {
  final String name;

  const _MockScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Screen: $name'),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop('result-from-$name'),
            child: const Text('Pop'),
          ),
        ],
      ),
    );
  }
}

class TestAppRouter extends AppRouter {
  final String testInitialLocation;
  final List<RouteBase> testRoutes;

  TestAppRouter({required this.testInitialLocation, required this.testRoutes});

  @override
  Future<String> getInitialLocation() async => testInitialLocation;

  @override
  List<RouteBase> get routes => testRoutes;
}
