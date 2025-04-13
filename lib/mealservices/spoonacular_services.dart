import 'dart:convert';
import 'package:http/http.dart' as http;

class SpoonacularService {
  static const String _apiKey = '79e8bd525cbb4a639c14c87df8015040';
  static const String _baseUrl =
      'https://api.spoonacular.com/recipes/complexSearch';

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
