import 'package:flutter/material.dart';

import '../../Controllers/auth_controller.dar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();

  void _login() async {
    try {
      await _authController.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.pushNamed(context, '/home'); // الانتقال للصفحة الرئيسية
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'خطأ: $e',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red, // لون الخلفية الحمراء
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FC), // خلفية فاتحة وجميلة
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
        backgroundColor: Color(0xFF4CAF50), // تغيير لون الشريط العلوي
        elevation: 0, // إزالة الظل من الشريط العلوي
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 100, color: Color(0xFF4CAF50),), // أيقونة تسجيل الدخول كبيرة
              SizedBox(height: 40),
              // حقل البريد الإلكتروني
              TextField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF4CAF50),), // أيقونة البريد الإلكتروني
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // حقل كلمة المرور
              TextField(
                controller: _passwordController,
                obscureText: true,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF4CAF50),), // أيقونة كلمة المرور
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // اللون الأساسي
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // حواف مدورة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                ),
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              // زر الانتقال إلى شاشة إنشاء حساب
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup'); // الانتقال لشاشة إنشاء الحساب
                },
                child: Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(color:Color(0xFF4CAF50), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
