import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controllers/button_controller.dart';
import 'User Interface/DESIGNER View/product_provider/photographer provider.dart';
import 'User Interface/DESIGNER View/product_provider/product.dart';
import 'User Interface/DESIGNER View/product_provider/productreviwe notifier.dart';
import 'User Interface/Welcome.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ButtonController()),
        ChangeNotifierProvider(create: (_) => PhotographerProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailNotifier()),


      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Set your design size (e.g., 375x812 for iPhone 11)
      minTextAdapt: true,               // Enables text size adaptation
      splitScreenMode: true,            // Allows support for split screen mode
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Welcome(),     // Your home screen
        );
      },
    );
  }
}
