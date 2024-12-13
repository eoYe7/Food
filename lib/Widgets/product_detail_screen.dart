import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProductDetailScreen extends StatelessWidget {
  final dynamic meal;  // تعريف المتغير meal

  const ProductDetailScreen({Key? key, required this.meal}) : super(key: key);  // إضافة المعامل

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          meal['name'] ?? 'اسم غير متوفر',  // عرض اسم المنتج
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            meal['image'] != null
                ? Image.asset(
              meal['image']!,  // عرض الصورة
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.image, size: 100),  // عرض أيقونة إذا كانت الصورة غير موجودة
            Text(
              'سعر: ${meal['price']} ر.س',  // عرض السعر
              style: TextStyle(fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            // يمكنك إضافة المزيد من التفاصيل حول المنتج هنا
          ],
        ),
      ),
    );
  }
}
