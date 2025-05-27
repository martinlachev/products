part of 'product_detail_bloc.dart';

class UpdateProductDetailFavourite extends BaseEvent {
  final bool isFavourite;

  const UpdateProductDetailFavourite(this.isFavourite);

  @override
  List<Object> get props => [isFavourite];
}
