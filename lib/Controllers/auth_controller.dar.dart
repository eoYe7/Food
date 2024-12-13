import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController {

  final String baseUrl = "http://10.0.2.2:8000/api/users/";


  // دالة التسجيل
  Future<void> signup(String username, String email, String password, String userType) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + "signup/"),
        body: {
          "username": username,
          "email": email,
          "password": password,
          "user_type": userType,
        },
      );

      if (response.statusCode != 201) {
        if (response.headers['content-type']!.contains('application/json')) {
          throw json.decode(response.body)["error"];
        } else {
          throw "Unexpected response format: ${response.body}";
        }
      }

    } catch (e) {
      print('Error during signup: $e');
      rethrow;
    }
  }

  // دالة التحقق من رمز التحقق


  // دالة إرسال رمز التحقق إلى البريد الإلكتروني
  Future<void> sendVerificationCode(String email) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + "send_verification_code/"),
        body: {
          "email": email,
        },
      );

      if (response.statusCode != 200) {
        if (response.headers['content-type']!.contains('application/json')) {
          throw json.decode(response.body)["error"];
        } else {
          throw "Unexpected response format: ${response.body}";
        }
      }
    } catch (e) {
      print('Error during sending verification code: $e');
      rethrow;
    }
  }


  Future<void> verifyCode(String email, String code) async {
    try {
      final response = await http.post(

        Uri.parse('http://10.0.2.2:8000/api/users/verify/'),
        body: {
          'email': email,
          'verification_code': code,
        },
      );

      if (response.statusCode == 200) {
        print('تم التحقق بنجاح');
      } else {
        final error = json.decode(response.body)["error"];
        throw error ?? "حدث خطأ أثناء التحقق.";
      }
    } catch (e) {
      print('Error during verification: $e');
      rethrow;
    }
  }

  // دالة تسجيل الدخول
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + "login/"),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Login successful: ${data}');
        // الانتقال إلى صفحة "Home"
      } else {
        final error = json.decode(response.body)["error"];
        throw error ?? "filed.";
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
  }

}
