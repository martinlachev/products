import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:features/products/bloc/product_bloc.dart';

void main() {
  group('ProductBloc', () {
    late ProductBloc bloc;

    setUp(() {
      bloc = ProductBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is empty', () {
      expect(bloc.state, const ProductState());
    });

    blocTest<ProductBloc, ProductState>(
      'emits initial batch of products when LoadProducts is added',
      build: () => ProductBloc(),
      wait: const Duration(milliseconds: 100),
      expect:
          () => [
            isA<ProductState>().having((s) => s.products.length, 'length', 20),
          ],
    );

    blocTest<ProductBloc, ProductState>(
      'toggles favorite on an existing product',
      build: () => ProductBloc(),
      act: (b) async {
        await Future.delayed(const Duration(milliseconds: 100));
        final first = b.state.products.first;
        b.add(ToggleFavorite(first));
      },
      wait: const Duration(milliseconds: 50),
      expect:
          () => [
            isA<ProductState>(), // initial
            isA<ProductState>().having(
              (s) => s.products.first.isFavorite,
              'first.isFavorite',
              true,
            ),
          ],
    );
  });
}
