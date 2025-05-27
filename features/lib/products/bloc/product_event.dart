part of 'product_bloc.dart';

class LoadProducts extends BaseEvent {
  const LoadProducts();
}

class LoadMoreProducts extends BaseEvent {
  const LoadMoreProducts();
}

class AddProduct extends BaseEvent {
  final String title;
  final String description;
  const AddProduct(this.title, this.description);
  @override
  List<Object?> get props => [title, description];
}

class RemoveProduct extends BaseEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class ToggleFavorite extends BaseEvent {
  final Product product;

  const ToggleFavorite(this.product);

  @override
  List<Object?> get props => [product];
}

class RedirectToProductDetail extends BaseEvent {
  final Product product;

  const RedirectToProductDetail(this.product);

  @override
  List<Object?> get props => [product];
}
