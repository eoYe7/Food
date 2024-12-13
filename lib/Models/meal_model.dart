class Meal {
  final String name;
  final double price;
  final String description;
  final String image;

  Meal({required this.name, required this.price, required this.description, required this.image});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
    );
  }
}
