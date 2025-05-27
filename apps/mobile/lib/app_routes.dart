import 'package:features/features.dart';
import 'package:utils/utils.dart';

class MobileRouter extends AppRouter {
  @override
  Future<String> getInitialLocation() async {
    return ProductRoutes.products.path;
  }

  @override
  List<RouteBase> get routes => [...ProductRoutes.routes()];
}
