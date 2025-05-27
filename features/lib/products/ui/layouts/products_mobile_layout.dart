import 'package:features/features.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class MobileProductsLayout extends StatelessWidget {
  const MobileProductsLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ProductGridPage(),
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
