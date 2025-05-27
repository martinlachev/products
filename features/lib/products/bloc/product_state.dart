part of 'product_bloc.dart';

class ProductState extends BaseState {
  final bool hasReachedMax;
  final bool isLoadingMore;
  final List<Product> products;

  const ProductState({
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.products = const [],
    super.status = AsyncStatus.initial,
  });

  @override
  ProductState copyWith({
    List<Product>? products,
    AsyncStatus? status,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, isLoadingMore];
}
