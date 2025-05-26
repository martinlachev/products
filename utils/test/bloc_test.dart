import 'package:utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BaseBloc logic tests', () {
    late TestBloc bloc;

    setUp(() {
      bloc = TestBloc();
    });

    blocTest<TestBloc, TestState>(
      'emits [loading] when status changes to loading',
      build: () => bloc,
      act: (bloc) => bloc.changeStatus(AsyncStatus.loading),
      expect: () => const [TestState(status: AsyncStatus.loading)],
    );

    blocTest<TestBloc, TestState>(
      'emits [globalLoading] when status changes to globalLoading',
      build: () => bloc,
      act: (bloc) => bloc.changeStatus(AsyncStatus.globalLoading),
      expect: () => const [TestState(status: AsyncStatus.globalLoading)],
    );

    blocTest<TestBloc, TestState>(
      'emits [error] when status changes to error',
      build: () => bloc,
      act: (bloc) => bloc.changeStatus(AsyncStatus.error),
      expect: () => const [TestState(status: AsyncStatus.error)],
    );
  });

  group('BaseBloc widget tests', () {
    late TestAppRouter testRouter;
    late TestBloc bloc;

    setUp(() {
      testRouter = TestAppRouter();
      DI.registerInstance<AppRouter>(testRouter);
      bloc = TestBloc();
    });

    tearDown(() async {
      DI.unregisterInstance<AppRouter>(testRouter);
      await bloc.close();
    });

    testWidgets(
      'displays global loading overlay on AsyncStatus.globalLoading',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            navigatorKey: testRouter.navigatorKey,
            scaffoldMessengerKey: testRouter.scaffoldKey,
            home: BlocProvider<TestBloc>.value(
              value: bloc,
              child: const SizedBox(),
            ),
            builder: (context, child) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return child!;
                    },
                  ),
                ],
              );
            },
          ),
        );

        bloc.changeStatus(AsyncStatus.globalLoading);
        await tester.pumpAndSettle();

        expect(find.byType(Preloader), findsOneWidget);

        bloc.changeStatus(AsyncStatus.success);
        await tester.pumpAndSettle();

        expect(find.byType(Preloader), findsNothing);
      },
    );

    testWidgets('shows snackbar on AsyncStatus.error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: testRouter.navigatorKey,
          scaffoldMessengerKey: testRouter.scaffoldKey,
          home: BlocProvider<TestBloc>.value(
            value: bloc,
            child: const Scaffold(body: SizedBox()),
          ),
        ),
      );

      bloc.changeStatus(AsyncStatus.error, errorMessage: 'oops');
      await tester.pumpAndSettle();

      expect(find.text('oops'), findsOneWidget);
    });
  });
}

// -----------------------------
// MOCK SETUP
// -----------------------------

class TestState extends BaseState {
  const TestState({super.status});

  @override
  TestState copyWith({AsyncStatus? status}) {
    return TestState(status: status ?? this.status);
  }
}

class TestBloc extends BaseBloc<TestState> {
  TestBloc() : super(const TestState());

  void changeStatus(AsyncStatus status, {String errorMessage = ''}) {
    add(StatusChanged(status: status, errorMessage: errorMessage));
  }
}

class TestAppRouter extends AppRouter {
  @override
  Future<String> getInitialLocation() async => '/';

  @override
  List<RouteBase> get routes => [];
}
