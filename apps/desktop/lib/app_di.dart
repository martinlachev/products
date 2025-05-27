import 'package:desktop/desktop.dart';
import 'package:utils/utils.dart';

final class AppDI extends DIComponents {
  @override
  Future<void> registerModules() async {
    await super.registerModules();

    DI.registerInstance<AppRouter>(DesktopRouter());
  }
}
