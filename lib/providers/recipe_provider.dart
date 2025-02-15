import 'package:flutter/foundation.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _errorMessage = '';
  final ApiService _apiService = ApiService();

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> searchRecipes(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _recipes = await _apiService.fetchRecipes(query);
    } catch (e) {
      _errorMessage = e.toString();
      _recipes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
