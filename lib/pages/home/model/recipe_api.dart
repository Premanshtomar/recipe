

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe/pages/home/model/recipe_model.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipes() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});
    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "6576433707mshf61f6fdcb27fc1cp1064c2jsn56bd3467d10d",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true",
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    List temp = [];

    for (var i in data['feed']) {
      temp.add(i['content']);
      if ( temp.length == 14) break;
    }

    // print(temp);
    return Recipe.recipesFromSnapshot(temp);
  }
}
