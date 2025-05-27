import 'package:features/features.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductBloc>();

    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 200) {
          bloc.add(LoadMoreProducts());
        }
        return false;
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final items = state.products;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: items.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= items.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Preloader(),
                  ),
                );
              }
              final product = items[index];
              return GestureDetector(
                onTap: () {
                  bloc.add(RedirectToProductDetail(product));
                },
                onLongPress: () {
                  bloc.add(RemoveProduct(product));
                },
                child: ProductCard(product: product),
              );
            },
          );
        },
      ),
    );
  }
}
