import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/foodcard.dart';
import 'package:foodfinder_app/Data/foodcard_storage.dart';
import 'package:foodfinder_app/pages/recipe_page.dart';

class FoodcardDesign extends StatefulWidget {
  final Foodcard foodcard;
  const FoodcardDesign({super.key, required this.foodcard});

  @override
  _FoodcardDesignState createState() => _FoodcardDesignState();
}

class _FoodcardDesignState extends State<FoodcardDesign> {
  bool isLiked = false; // ADDED

  @override
  void initState() {
    FoodcardStorage().getLikedRecipeIds().then((List<String> likedIds){
      if(likedIds.contains(widget.foodcard.id)){
        setState(() {
          isLiked = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipePage(
                recipe: widget.foodcard,
                zutaten: List.generate(widget.foodcard.ingredients.length, (int index){
                  return [widget.foodcard.ingredients[index][0].toString(), widget.foodcard.ingredients[index][1].toString(), widget.foodcard.ingredients[index][2].toString()];
                }),
                portionen: int.parse(widget.foodcard.portion)
              )
            ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Container(
          height: 138,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bild
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: widget.foodcard.imageURL.contains("assets") ? Image.asset(
                        widget.foodcard.imageURL, // MODIFIED
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ) : Image.file(
                        File(widget.foodcard.imageURL), // MODIFIED
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // Titel, Tags und Description
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              widget.foodcard.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 20,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 6),
                            color: Theme.of(context).colorScheme.primary,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 0
                                    ),
                                    margin: EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      color: widget.foodcard.foodart == "Fleisch" ? Theme.of(context).colorScheme.secondary : widget.foodcard.foodart == "Veggie" ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.foodcard.foodart, // MODIFIED
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 11,
                                          letterSpacing: 0.6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ), // vegan/veggie/fleisch
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: int.parse(widget.foodcard.price) == 1 ? 6 : 4,
                                      vertical: 1
                                    ),
                                    margin: EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: Wrap(
                                      spacing: -1.0,
                                      children: List.generate(int.parse(widget.foodcard.price), (int index){
                                        return const Icon(Icons.euro, size: 12);
                                      }),
                                    ),
                                  ), // preis
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: int.parse(widget.foodcard.time) == 1 ? 6 : 4,
                                      vertical: 1
                                    ),
                                    margin: EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: Wrap(
                                      spacing: -1,
                                      children: List.generate(int.parse(widget.foodcard.time), (int index){
                                        return const Icon(Icons.schedule, size: 12);
                                      }),
                                    ),
                                  ), // zeit
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: int.parse(widget.foodcard.waterneed) == 1 ? 6 : 4,
                                      vertical: 1
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: Wrap(
                                      spacing: -2,
                                      children: List.generate(int.parse(widget.foodcard.waterneed), (int index){
                                        return const Icon(Icons.water_drop_outlined, size: 12);
                                      }),
                                    ),
                                  ), // wasser
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(
                              widget.foodcard.description, // MODIFIED
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 12,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Herz für Favoriten
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 90,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isLiked = !isLiked;
                      });

                      if(isLiked){
                        FoodcardStorage().likeRecipe(widget.foodcard.id);
                      }else{
                        FoodcardStorage().unlikeRecipe(widget.foodcard.id);
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        );
                        return ScaleTransition(
                          scale: curvedAnimation,
                          child: child,
                        );
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey<bool>(isLiked),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
