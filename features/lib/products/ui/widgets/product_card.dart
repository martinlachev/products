import 'package:features/features.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        key: ValueKey(product.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.description.length > 50
                    ? '${product.description.substring(0, 50)}…'
                    : product.description,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed:
                    () => context.read<ProductBloc>().add(
                      ToggleFavorite(product),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
