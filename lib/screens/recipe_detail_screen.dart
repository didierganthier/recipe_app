import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_html_css/simple_html_css.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: recipe.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 16.0),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Source: ${recipe.sourceName}'),
            Text('Ready in ${recipe.readyInMinutes} minutes'),
            Text('Servings: ${recipe.servings}'),
            const SizedBox(height: 16.0),
            const Text(
              'Summary:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              recipe.summary,
              style: const TextStyle(fontSize: 16.0, height: 1.4),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(recipe.sourceUrl))) {
                  await launchUrl(Uri.parse(recipe.sourceUrl));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Could not launch source URL')),
                  );
                }
              },
              child: const Text('View Original Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
