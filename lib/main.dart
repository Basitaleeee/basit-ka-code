import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controllers/button_controller.dart';
import 'User Interface/Admin/Dashboard Screen.dart';
import 'User Interface/Customer View/Home Screen.dart';
import 'User Interface/DESIGNER View/HOME.dart';
import 'User Interface/DESIGNER View/product_provider/photographer provider.dart';
import 'User Interface/DESIGNER View/product_provider/product.dart';
import 'User Interface/DESIGNER View/product_provider/productreviwe notifier.dart';
import 'User Interface/DESIGNER View/product_provider/social links provider.dart';
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
        //ChangeNotifierProvider(create: (_) => SocialLinksProvider()),



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
          home:  AuthWrapper(),     // Your home screen
        );
      },
    );
  }

}
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role'); // Fetch role from SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          String role = snapshot.data!;
          if (role == 'Admin') {
            return DashboardScreen();
          } else if (role == 'CUSTOMER') {
            return CustomerHomeScreen();
          } else if (role == 'DESIGNER') {
            return HomeScreen();
          }
        }

        return Welcome(); // Default to Welcome screen for new users
      },
    );
  }
}

