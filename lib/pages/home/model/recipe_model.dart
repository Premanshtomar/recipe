class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;
  final List preparation;

  Recipe(
      {required this.name,
      required this.images,
      required this.rating,
      required this.totalTime,
      this.preparation = const []});

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        preparation: json['preparationSteps'] as List,
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

// @override
// String toString(){
//   return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime}';
// }
}
