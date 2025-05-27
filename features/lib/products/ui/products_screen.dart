import 'dart:io';

import 'package:features/products/_exports.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isAndroid) {
      return MobileProductsLayout();
    }

    return const DesktopProductsLayout();
  }
}
