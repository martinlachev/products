import 'dart:async';

import 'package:utils/utils.dart';
import 'package:features/features.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductState> {
  int _nextId = 0;
  static const int _batchSize = 20;

  ProductBloc() : super(const ProductState()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<ToggleFavorite>(_onToggleFavorite);
    on<RedirectToProductDetail>(_onRedirectToProductDetail);
  }

  @override
  void onInitialized(Initialized event, Emitter<ProductState> emit) {
    super.onInitialized(event, emit);

    add(LoadProducts());
  }

  FutureOr<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    final initial = List.generate(_batchSize, (i) {
      final id = Uuid().v4();
      return Product(
        id: Uuid().v4(),
        title: 'Product $id',
        description: 'Description for product $id',
      );
    });
    _nextId += _batchSize;
    emit(state.copyWith(products: initial, hasReachedMax: false));
  }

  void _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    // simulate latency
    await Future.delayed(const Duration(milliseconds: 500));

    final more = List.generate(_batchSize, (i) {
      final id = Uuid().v4();

      return Product(
        id: id,
        title: 'Product $id',
        description: 'Description for product $id',
      );
    });

    _nextId += _batchSize;

    final all = List<Product>.from(state.products)..addAll(more);
    emit(
      state.copyWith(
        products: all,
        hasReachedMax: _nextId > 100,
        isLoadingMore: false,
      ),
    );
  }

  FutureOr<void> _onAddProduct(AddProduct event, Emitter<ProductState> emit) {
    final newProduct = Product(
      id: Uuid().v4(),
      title: event.title,
      description: event.description,
    );
    emit(state.copyWith(products: [newProduct, ...state.products]));
  }

  FutureOr<void> _onRemoveProduct(
    RemoveProduct event,
    Emitter<ProductState> emit,
  ) {
    final updated =
        state.products.where((p) => p.id != event.product.id).toList();
    emit(state.copyWith(products: updated));
  }

  FutureOr<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<ProductState> emit,
  ) {
    final updated =
        state.products.map((p) {
          if (p.id == event.product.id) {
            return p.copyWith(isFavorite: !p.isFavorite);
          }
          return p;
        }).toList();
    emit(state.copyWith(products: updated));
  }

  FutureOr<void> _onRedirectToProductDetail(
    RedirectToProductDetail event,
    Emitter<ProductState> emit,
  ) async {
    final newProduct =
        await resolve<AppRouter>().push(
              route: ProductRoutes.productDetail,
              parameters: event.product,
            )
            as Product?;

    if (newProduct == null) return;

    add(ToggleFavorite(newProduct));
  }
}
