import 'package:flutter/material.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  const ResponsivePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    double padding;

    if (width >= 1200) {
      // desktop
      padding = width * 0.2;
    } else if (width >= 800) {
      // tablet
      padding = 16;
    } else {
      // mobile
      padding = 8;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
