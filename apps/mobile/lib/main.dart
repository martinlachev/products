import 'package:flutter/rendering.dart';
import 'package:mobile/mobile.dart';
import 'package:utils/utils.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugRepaintRainbowEnabled = false;
  // Register the DI modules
  await DI.init(components: AppDI());

  // Initialize the app router
  final appRouter = await DI.resolve<AppRouter>().initialize();

  runApp(
    Builder(
      builder: (context) {
        final textTheme = createTextTheme(context, "Poppins", "Denk One");
        final theme = MaterialTheme(textTheme);

        return MaterialApp.router(
          title: 'Products Mobile',
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: theme.light(),
          darkTheme: theme.dark(),
        );
      },
    ),
  );
}
