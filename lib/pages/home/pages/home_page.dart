import 'package:flutter/material.dart';
import 'package:recipe/pages/details/details.dart';
import 'package:recipe/pages/home/utils/drawer.dart';

import '../model/recipe_api.dart';
import '../model/recipe_model.dart';
import '../utils/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipes();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.restaurant_menu,
                color: Colors.black,
              ),
              // SizedBox(width: 10),
              Text(
                'Food Recipes',
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
        ),
        drawer: MyDrawer(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Details(recipe: _recipes[index]),
                      //   ),
                      // );
                      Navigator.pushNamed(context, Details.routeName, arguments: _recipes[index]);
                    },
                    child: RecipeCard(
                        title: _recipes[index].name,
                        cookTime: _recipes[index].totalTime,
                        rating: _recipes[index].rating.toString(),
                        thumbnailUrl: _recipes[index].images),
                  );
                },
              ));
  }
}
