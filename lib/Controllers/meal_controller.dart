import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/meal_model.dart';

class MealController {
  static Future<List<Meal>> fetchMeals() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/meals/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
