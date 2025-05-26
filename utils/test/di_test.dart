import 'package:kiwi/kiwi.dart';
import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  group('DI Container', () {
    setUp(() async {
      await DI.init(components: TestDIComponents());
    });

    test('should resolve registered instance', () {
      final service = resolve<MockService>();
      expect(service, isA<MockService>());
      expect(service.data, equals('mock'));
    });

    test('should unregister instance', () {
      final service = resolve<MockService>();
      DI.unregisterInstance(service);
      expect(
        () => resolve<MockService>(),
        throwsA(isA<NotRegisteredKiwiError>()),
      );
    });
  });
}

// -----------------------------
// MOCK SETUP
// -----------------------------

class MockService {
  String get data => 'mock';
}

class TestDIComponents extends DIComponents {
  @override
  Future<void> registerModules() async {
    DI.registerInstance<MockService>(MockService());
  }
}
