import 'package:flutter/material.dart';
import 'package:food_delivery_app/views/orders/order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> orders = [
      {'orderId': 'طلب رقم 1', 'status': 'قيد التحضير', 'price': '45.00 ر.س'},
      {'orderId': 'طلب رقم 2', 'status': 'تم التوصيل', 'price': '30.00 ر.س'},
      {'orderId': 'طلب رقم 3', 'status': 'قيد التحضير', 'price': '20.00 ر.س'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('الطلبات'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // محاذاة النصوص لليمين
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return InkWell(
              onTap: () {
                // التنقل إلى شاشة التفاصيل عند الضغط
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(orderId: order['orderId']!),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Align(
                    alignment: Alignment.centerRight, // محاذاة النص لليمين
                    child: Text(
                      order['orderId']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Align(
                    alignment: Alignment.centerRight, // محاذاة النص لليمين
                    child: Text(
                      'الحالة: ${order['status']} - السعر: ${order['price']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.green),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
