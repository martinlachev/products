import 'package:features/features.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (_) => _showAddDialog(context),
            itemBuilder:
                (_) => [
                  PopupMenuItem(value: 'add', child: Text('Add Product')),
                ],
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
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
                      child: CircularProgressIndicator(),
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
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    String title = '';
    String description = '';
    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Add Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (v) => title = v,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (v) => description = v,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ProductBloc>().add(
                    AddProduct(title, description),
                  );
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          ),
    );
  }
}
