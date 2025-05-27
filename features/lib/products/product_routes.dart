import 'package:utils/utils.dart';
import 'package:features/features.dart';

enum ProductRoutes implements AppRoute {
  products(path: '/products', name: 'Products'),
  productDetail(path: '/product-detail', name: 'ProductDetail');

  @override
  final String path;
  @override
  final String name;

  const ProductRoutes({required this.path, required this.name});

  @override
  RouteBase get route {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) {
        switch (this) {
          case ProductRoutes.products:
            return BlocProvider(
              create: (context) => ProductBloc(),
              child: const ProductsScreen(),
            );
          case ProductRoutes.productDetail:
            final product = state.extra as Product?;

            return BlocProvider(
              create: (context) => ProductDetailBloc(product: product),
              child: const ProductDetailScreen(),
            );
        }
      },
    );
  }

  static List<RouteBase> routes() {
    return values.map((route) => route.route).toList();
  }
}
