import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _mealNameController = TextEditingController();
  final _mealDescriptionController = TextEditingController();
  final _mealPriceController = TextEditingController();
  final _mealCategoryController = TextEditingController();

  File? _mealImage; // لتخزين صورة الوجبة

  // قائمة الفئات
  final List<String> categories = ['مقبلات', 'أطباق رئيسية', 'حلويات', 'مشروبات'];

  // دالة لاختيار الصورة
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery); // اختر من المعرض
    if (pickedFile != null) {
      setState(() {
        _mealImage = File(pickedFile.path);
      });
    }
  }

  // دالة لإرسال البيانات إلى الـAPI
  Future<void> _addMeal() async {
    final url = 'https://your-api-url.com/api/add-meal/'; // رابط الـAPI هنا
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // إضافة الحقول النصية
    request.fields['name'] = _mealNameController.text;
    request.fields['description'] = _mealDescriptionController.text;
    request.fields['price'] = _mealPriceController.text;
    request.fields['category'] = _mealCategoryController.text;

    // إضافة الصورة إذا كانت موجودة
    if (_mealImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _mealImage!.path,
      ));
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      // تم إضافة الوجبة بنجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إضافة الوجبة بنجاح')),
      );
    } else {
      // حدث خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في إضافة الوجبة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('إضافة وجبة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // لضبط المحاذاة إلى اليمين
            children: <Widget>[
              TextField(
                controller: _mealNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الوجبة',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontFamily: 'ArabicFont'),
                ),
                textAlign: TextAlign.right, // محاذاة النص إلى اليمين داخل الـinput
                textDirection: TextDirection.rtl, // محاذاة النص داخل الـinput من اليمين
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _mealDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'وصف الوجبة',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontFamily: 'ArabicFont'),
                ),
                textAlign: TextAlign.right, // محاذاة النص إلى اليمين داخل الـinput
                textDirection: TextDirection.rtl, // محاذاة النص داخل الـinput من اليمين
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _mealPriceController,
                decoration: const InputDecoration(
                  labelText: 'السعر',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontFamily: 'ArabicFont'),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right, // محاذاة النص إلى اليمين داخل الـinput
                textDirection: TextDirection.rtl, // محاذاة النص داخل الـinput من اليمين
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: categories.first,
                onChanged: (value) {
                  setState(() {
                    _mealCategoryController.text = value!;
                  });
                },
                items: categories
                    .map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: const TextStyle(fontFamily: 'ArabicFont'),
                  ),
                ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'الفئة',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontFamily: 'ArabicFont'),
                ),
              ),
              const SizedBox(height: 16),
              _mealImage == null
                  ? ElevatedButton(
                onPressed: _pickImage,
                child: const Text('اختيار صورة'),
              )
                  : Image.file(
                _mealImage!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Center( // لتوسيط الزر في الصفحة
                child: ElevatedButton(
                  onPressed: _addMeal,
                  child: const Text('إضافة الوجبة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
