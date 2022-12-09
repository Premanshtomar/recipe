import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/pages/home/model/recipe_model.dart';

class Details extends StatefulWidget {
  static const String routeName = '/details/';

  // final Recipe? recipe;
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var systemDark = true;

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
            systemOverlayStyle: systemDark
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,color: systemDark? Colors.black: Colors.white,
                ),
              ),
            ),

            // backgroundColor: Colors.red,
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: LayoutBuilder(
                builder: (context, constraints) {
                  var isCompact = constraints.maxHeight >
                      MediaQuery.of(context).size.height * 0.14;
                  WidgetsBinding.instance.addPostFrameCallback((_) {

                    if (isCompact) {
                      setState(() {
                        systemDark = false;
                      });
                    } else {
                      setState(() {
                        systemDark = true;
                      });
                    }
                  });

                  return Text(
                    recipe?.name ?? '',
                    style: TextStyle(
                      color: isCompact
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                },
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
                    // margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Preparation Steps:',
                            style: TextStyle(fontWeight: FontWeight.w700),
                            textScaleFactor: 1.5,
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipe.preparation?.length,
                          itemBuilder: (BuildContext context, int index1) {
                            return Container(
                                padding: EdgeInsets.fromLTRB(
                                    32,
                                    8,
                                    8,
                                    index1 == (recipe.preparation!.length - 1)
                                        ? 24
                                        : 8),
                                color: index1.isOdd
                                    ? Colors.white
                                    : Colors.black12,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Step ${index1 + 1}.\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${recipe.preparation?[index1]}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ]),
                                ));
                          },
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
