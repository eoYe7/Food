// lib/models/order.dart
class Order {
  final String meal;
  final String quantity;
  final String price;
  final String status;
  final String image;

  Order({
    required this.meal,
    required this.quantity,
    required this.price,
    required this.status,
    required this.image,
  });
}
