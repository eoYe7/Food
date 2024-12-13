import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/Widgets/product_detail_screen.dart';
import '../../Models/meals_data.dart';
import '../Views/Payment/payment_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meals = mealsData[categoryName] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          categoryName,
          textDirection: TextDirection.rtl,
        ),
      ),
      body: meals.isNotEmpty
          ? ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                // التحقق من أن بيانات المنتج ليست فارغة أو غير صحيحة
                if (meal != null && meal['name'] != null && meal['image'] != null) {
                  print("تم الضغط على المنتج: ${meal['name']}");
                  Get.to(() => ProductDetailScreen(meal: meal)); // التنقل مع تمرير meal
                } else {
                  print("المنتج غير موجود أو البيانات غير صحيحة");
                  Get.snackbar("خطأ", "المنتج غير موجود أو البيانات غير صحيحة");
                }
              },

              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                trailing: meal['image'] != null
                    ? Image.asset(
                  meal['image']!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                )
                    : const Icon(Icons.image, size: 50),
                title: Text(
                  meal['name']!,
                  textDirection: TextDirection.rtl,
                ),
                subtitle: Text(
                  'سعر: ${meal['price']} ر.س',
                  textDirection: TextDirection.rtl,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // فتح صفحة الدفع
                    Get.to(() => PaymentScreen());
                  },
                ),
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
