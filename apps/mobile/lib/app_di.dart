import 'package:utils/utils.dart';
import 'package:mobile/mobile.dart';

final class AppDI extends DIComponents {
  @override
  Future<void> registerModules() async {
    await super.registerModules();

    DI.registerInstance<AppRouter>(MobileRouter());
  }
}
