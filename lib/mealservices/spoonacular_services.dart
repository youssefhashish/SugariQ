import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SpoonacularService {
  static final _apiKey = dotenv.env['SPOONCULAR_API_KEY'];
  static final _baseUrl = dotenv.env['SPOONCULAR_API_URL'];

  static Future<List<MealItem>> fetchMeals() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?number=10&addRecipeNutrition=true&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => MealItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}

class MealItem {
  final String title;
  final String image;
  final int calories;
  final double carbs;

  MealItem({
    required this.title,
    required this.image,
    required this.calories,
    required this.carbs,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      title: json['title'] ?? 'Unknown',
      image: json['image'] ?? '',
      calories: (json['nutrition']['nutrients'] as List)
              .firstWhere((n) => n['name'] == 'Calories',
                  orElse: () => {'amount': 0})['amount']
              ?.toInt() ??
          0,
      carbs: (json['nutrition']['nutrients'] as List)
              .firstWhere((n) => n['name'] == 'Carbohydrates',
                  orElse: () => {'amount': 0})['amount']
              ?.toDouble() ??
          0.0,
    );
  }
}
