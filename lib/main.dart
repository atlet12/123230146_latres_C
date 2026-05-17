import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/cart_item_model.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Toko Anikwork',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Obx(
        () {
          final authController = Get.put(AuthController());
          return authController.isLoggedIn.value ? const MainScreen() : const LoginScreen();
        },
      ),
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const MainScreen()),
        GetPage(name: '/product-detail', page: () => const ProductDetailScreen()),
        GetPage(name: '/cart', page: () => const CartScreen()),
      ],
    );
  }
}
