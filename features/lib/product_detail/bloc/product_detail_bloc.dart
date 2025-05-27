import 'dart:async';

import 'package:features/features.dart';
import 'package:utils/utils.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends BaseBloc<ProductDetailState> {
  final Product? product;

  ProductDetailBloc({this.product}) : super(const ProductDetailState()) {
    on<UpdateProductDetailFavourite>(_onUpdateProductDetailFavourite);
  }

  @override
  void onInitialized(Initialized event, Emitter<ProductDetailState> emit) {
    super.onInitialized(event, emit);

    if (product != null) {
      emit(state.copyWith(product: product));
    }
  }

  FutureOr<void> _onUpdateProductDetailFavourite(
    UpdateProductDetailFavourite event,
    Emitter<ProductDetailState> emit,
  ) {
    final updatedProduct = state.product?.copyWith(
      isFavorite: event.isFavourite,
    );
    emit(state.copyWith(product: updatedProduct));
  }
}
