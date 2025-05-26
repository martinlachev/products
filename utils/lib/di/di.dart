import 'package:kiwi/kiwi.dart';
import 'package:utils/utils.dart';

S resolve<S>() => DI.resolve<S>();

abstract class DI {
  static final _container = KiwiContainer();

  static T resolve<T>() => _container.resolve<T>();

  static void registerInstance<S>(S instance) async {
    if (_container.isRegistered<S>()) {
      _container.unregister<S>();
    }

    _container.registerInstance<S>(instance);
  }

  static void unregisterInstance<S>(S instance) {
    _container.unregister<S>();
  }

  static Future<void> init({required DIComponents components}) async {
    await components.registerModules();
  }
}
