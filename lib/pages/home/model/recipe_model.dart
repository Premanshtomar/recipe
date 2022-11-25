class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;
  final List? preparation;
  final String? description;

  Recipe(
      {required this.name,
      required this.images,
      required this.rating,
      required this.totalTime,
      this.preparation = const [''],
      this.description = 'No Description Available'});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        description: json['description']?['text'] as String?,
        preparation: json['preparationSteps'] as List?,
        name: json['details']?['name'] as String,
        images: json['details']['images'][0]['hostedLargeUrl'] as String,
        rating: json['details']['rating'] as double,
        totalTime: json['details']['totalTime'] as String);
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
