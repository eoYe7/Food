import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل $orderId'),
        backgroundColor: Colors.green,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // تحديد اتجاه النصوص إلى اليمين
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // العناصر تبدأ من اليسار افتراضياً
            children: [
              Align(
                alignment: Alignment.centerRight, // محاذاة العنصر إلى اليمين
                child: Text(
                  'رقم الطلب: $orderId',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight, // محاذاة العنصر إلى اليمين
                child: Text(
                  'تفاصيل الطلب هنا...',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
