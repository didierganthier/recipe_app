class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final String sourceName;
  final String sourceUrl;
  final String summary;
  final int readyInMinutes;
  final int servings;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.sourceUrl,
    required this.summary,
    required this.readyInMinutes,
    required this.servings,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      sourceName: json['sourceName'] ?? 'Unknown',
      sourceUrl: json['sourceUrl'] ?? '#',
      summary: json['summary'] ?? 'No summary available',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
    );
  }
}
