import 'package:utils/utils.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isFavorite];
}
