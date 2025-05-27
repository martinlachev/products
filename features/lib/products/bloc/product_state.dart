part of 'product_bloc.dart';

class ProductState extends BaseState {
  final bool isLoadingMore;
  final List<Product> products;

  const ProductState({
    this.isLoadingMore = false,
    this.products = const [],
    super.status = AsyncStatus.initial,
  });

  @override
  ProductState copyWith({
    List<Product>? products,
    AsyncStatus? status,
    bool? isLoadingMore,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [status, products, isLoadingMore];
}
