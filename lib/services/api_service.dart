import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
  final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';

  Future<List<Recipe>> fetchRecipes(String query) async {
    final url = Uri.parse(
        '${baseUrl}complexSearch?apiKey=$apiKey&query=$query&addRecipeInformation=true');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final List<dynamic> results = decodedData['results'];

        return results.map((recipe) => Recipe.fromJson(recipe)).toList();
      } else {
        throw Exception(
            'Failed to load recipes. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }
}
