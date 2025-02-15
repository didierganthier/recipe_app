import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import 'recipe_detail_screen.dart'; // Import RecipeDetailScreen
import 'package:cached_network_image/cached_network_image.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Recipes',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    recipeProvider.searchRecipes(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                recipeProvider.searchRecipes(value);
              },
            ),
          ),
          Expanded(
            child: recipeProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : recipeProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(recipeProvider.errorMessage))
                    : recipeProvider.recipes.isEmpty
                        ? const Center(
                            child: Text(
                                'No recipes found. Try a different search.'))
                        : ListView.builder(
                            itemCount: recipeProvider.recipes.length,
                            itemBuilder: (context, index) {
                              final recipe = recipeProvider.recipes[index];
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecipeDetailScreen(recipe: recipe),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: recipe.imageUrl,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: double.infinity,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          recipe.title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('Source: ${recipe.sourceName}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
