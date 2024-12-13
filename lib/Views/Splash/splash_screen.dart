import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/constants/app_colors.dart'; // ملف الألوان
import 'package:food_delivery_app/routes/app_routes.dart'; // إدارة التنقل
import 'package:shared_preferences/shared_preferences.dart'; // التحقق من حالة المستخدم

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // مدة الانتظار
    await Future.delayed(Duration(seconds: 3));

    // الانتقال دائمًا إلى الصفحة الرئيسية
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg', // شعار التطبيق
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Food Delivery App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
