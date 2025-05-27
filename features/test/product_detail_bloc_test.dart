import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:features/product_detail/bloc/product_detail_bloc.dart';
import 'package:features/products/model/product.dart';

void main() {
  group('ProductDetailBloc', () {
    final sample = Product(
      id: '123',
      title: 'Sample',
      isFavorite: false,
      description: 'A sample product',
    );
    late ProductDetailBloc bloc;

    setUp(() {
      bloc = ProductDetailBloc(product: sample);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state holds the injected product', () {
      expect(bloc.state.product, equals(sample));
    });

    blocTest<ProductDetailBloc, ProductDetailState>(
      'emits [initial, toggled] when UpdateProductDetailFavourite is added',
      build: () => ProductDetailBloc(product: sample),
      act: (b) => b.add(const UpdateProductDetailFavourite(true)),
      wait: const Duration(milliseconds: 100),
      expect:
          () => [
            // 1) The unchanged initial state
            isA<ProductDetailState>().having(
              (s) => s.product?.isFavorite,
              'initial isFavorite',
              false,
            ),
            // 2) The toggled state
            isA<ProductDetailState>().having(
              (s) => s.product?.isFavorite,
              'toggled isFavorite',
              true,
            ),
          ],
    );
  });
}
