import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final VoidCallback onCartPressed; // Define the onCartPressed callback

  const MealCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.onCartPressed, // Add the onCartPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // تعديل حجم الصورة هنا لتكون بحجم ثابت
          Container(
            height: 70, // تحديد ارتفاع ثابت للصورة
            width: 70, // عرض الصورة يعادل عرض الـ Card
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          SizedBox(width: 10), // مسافة بين الصورة والأيقونة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    price,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          // أيقونة سلة التسوق في الجهة اليمنى
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: onCartPressed, // Trigger the onCartPressed callback
          ),
        ],
      ),
    );
  }
}
