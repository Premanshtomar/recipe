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
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            pinned: true,
            // backgroundColor: Colors.red,
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe?.name ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              background: Image.network(
                recipe!.images,
                fit: BoxFit.fill,
                color: Colors.black.withOpacity(0.32),
                colorBlendMode: BlendMode.darken,
                // color: Colors.black.withOpacity(0.32),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description:',
                          style: TextStyle(fontWeight: FontWeight.w700),
                          textScaleFactor: 1.5,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.004,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '${recipe.description}',
                            textScaleFactor: 1.4,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.yellow,
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Preparation Steps:',
                          style: TextStyle(fontWeight: FontWeight.w700),
                          textScaleFactor: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipe.preparation?.length,
                            itemBuilder: (BuildContext context, int index1) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                color: index1.isOdd
                                    ? Colors.white
                                    : Colors.black12,
                                child: Text(
                                  'Step${index1 + 1}\n ${recipe.preparation?[index1]}',
                                  textScaleFactor: 1.4,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }, childCount: 1),
          )
        ],
      ),
    );
  }
}
