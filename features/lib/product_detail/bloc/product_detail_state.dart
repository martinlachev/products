part of 'product_detail_bloc.dart';

class ProductDetailState extends BaseState {
  final Product? product;

  const ProductDetailState({super.status = AsyncStatus.initial, this.product});

  @override
  ProductDetailState copyWith({AsyncStatus? status, Product? product}) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [status, product];
}
