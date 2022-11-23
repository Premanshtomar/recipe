import 'package:flutter/material.dart';
import 'package:recipe/pages/home/model/recipe_model.dart';
class Details extends StatelessWidget {
  static const String routeName = '/details/';
  // final Recipe? recipe;
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Recipe? recipe = ModalRoute.of(context)?.settings.arguments as Recipe?;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.black,
            pinned: true,
            // backgroundColor: Colors.red,
            expandedHeight: MediaQuery.of(context).size.height*0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe?.name ?? '',
              style: const TextStyle(
                // color: Colors.black
              ),
              ),
              background: Image.network(recipe!.images,
                fit:BoxFit.fill,
                color: Colors.black.withOpacity(0.32),
                colorBlendMode: BlendMode.darken,
                // color: Colors.black.withOpacity(0.32),
              ),
            ),
          )
        ],
      ),
    );
  }
}
