import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Preloader extends StatelessWidget {
  static const preloaderPath = 'assets/lotties/preloader.json';

  final double? size;

  const Preloader({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final defaultSize = MediaQuery.sizeOf(context).width * 0.5;

    return Lottie.asset(
      preloaderPath,
      width: size ?? defaultSize,
      height: size ?? defaultSize,
      fit: BoxFit.fill,
      repeat: true,
      reverse: false,
      animate: true,
    );
  }
}
