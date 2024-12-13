import 'package:flutter/material.dart';
import 'package:food_delivery_app/views/home/home_screen.dart' as home;
import 'package:food_delivery_app/views/orders/orders_screen.dart' as orders;
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'Views/Auth/login_screen.dart';
import 'Views/Auth/signup_screen.dart';
import 'Views/Splash/splash_screen.dart';
import 'Widgets/product_detail_screen.dart';  // إضافة الاستيراد لصفحة ProductDetailScreen

void main() {
  runApp(FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/home', page: () => home.HomeScreen()),
        GetPage(name: '/orders', page: () => orders.OrdersScreen()),

        // إضافة المسار لصفحة تفاصيل المنتج
        GetPage(name: '/productDetail', page: () => ProductDetailScreen(meal: {})),  // تأكد من تمرير قيمة meal المناسبة هنا
      ],
    );
  }
}
