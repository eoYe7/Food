import 'package:flutter/material.dart';
import '../../Models/meals_data.dart';
import '../Payment/payment_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName; // اسم التصنيف

  const CategoryScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meals = mealsData[categoryName] ?? []; // إذا لم يتم العثور على بيانات، تُرجع قائمة فارغة

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          categoryName,
          textDirection: TextDirection.rtl, // تعيين الكتابة من اليمين لليسار
        ),
      ),
      body: meals.isNotEmpty
          ? ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              // تغيير ترتيب leading و trailing هنا
              trailing: meal['image'] != null
                  ? Image.asset(
                meal['image']!, // الصورة المرتبطة بالوجبة
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              )
                  : const Icon(Icons.image, size: 50), // أيقونة إذا كانت الصورة مفقودة
              title: Text(
                meal['name']!,
                textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
              ),
              subtitle: Text(
                'سعر: ${meal['price']} ر.س',
                textDirection: TextDirection.rtl, // الكتابة من اليمين لليسار
              ),
              leading: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // فتح صفحة الدفع
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(), // استبدال بـ PaymentPage
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text('لا توجد بيانات متاحة لهذا التصنيف'),
      ),
    );
  }
}
