import 'package:features/features.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        leading: BlocSelector<ProductDetailBloc, ProductDetailState, Product?>(
          selector: (state) {
            return state.product;
          },
          builder: (context, product) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => resolve<AppRouter>().pop(product),
            );
          },
        ),
        actions: [
          BlocSelector<ProductDetailBloc, ProductDetailState, bool>(
            selector: (state) {
              return state.product?.isFavorite ?? false;
            },
            builder: (context, isFavorite) {
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed:
                    () => {
                      context.read<ProductDetailBloc>().add(
                        UpdateProductDetailFavourite(!isFavorite),
                      ),
                    },
              );
            },
          ),
        ],
      ),
      body: BlocSelector<ProductDetailBloc, ProductDetailState, Product?>(
        selector: (state) {
          return state.product;
        },
        builder: (context, product) {
          return Center(
            child: Text(
              product != null
                  ? '${product.title}\n\n${product.description}'
                  : 'No product selected',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
