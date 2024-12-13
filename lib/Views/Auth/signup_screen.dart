import 'package:flutter/material.dart';
import 'package:food_delivery_app/Views/Auth/verification_screen.dart';
import '../../Controllers/auth_controller.dar.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  String _userType = 'client'; // حدد نوع المستخدم (عميل أو طاهي)

  void _signup() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    try {
      await _authController.signup(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _userType,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerificationScreen(email: _emailController.text.trim()),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FC), // خلفية فاتحة وجميلة
      appBar: AppBar(
        title: Text('إنشاء حساب جديد'),
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
              Icon(Icons.person_add, size: 100, color: Color(0xFF4CAF50)), // أيقونة كبيرة
              SizedBox(height: 40),
              // حقل الاسم
              TextField(
                controller: _nameController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'الاسم',
                  prefixIcon: Icon(Icons.person, color: Color(0xFF4CAF50)), // أيقونة الاسم
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // حقل البريد الإلكتروني
              TextField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF4CAF50)), // أيقونة البريد الإلكتروني
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
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF4CAF50)), // أيقونة كلمة المرور
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // اختيار نوع المستخدم
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'client',
                    groupValue: _userType,
                    onChanged: (String? value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  Text('عميل'),
                  Radio<String>(
                    value: 'chef',
                    groupValue: _userType,
                    onChanged: (String? value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  Text('طاهي'),
                ],
              ),
              SizedBox(height: 30),
              // زر إنشاء الحساب
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // اللون الأساسي
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // حواف مدورة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                ),
                child: Text(
                  'إنشاء حساب',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
