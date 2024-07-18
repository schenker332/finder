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
          MaterialPageRoute(builder: (context) => RecipePage(
            recipe: widget.foodcard,
            zutaten: List.generate(widget.foodcard.ingredients.length, (int index){
              return [widget.foodcard.ingredients[index][0].toString(), widget.foodcard.ingredients[index][1].toString(), widget.foodcard.ingredients[index][2].toString()];
            }),
            portionen: int.parse(widget.foodcard.portion))
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 130,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.foodcard.imageURL, // MODIFIED
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.foodcard.title, // MODIFIED
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        color: Theme.of(context).colorScheme.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1
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
                                    fontSize: 10,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1
                              ),
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(int.parse(widget.foodcard.price), (int index){
                                  return const Icon(Icons.euro, size: 10);
                                }),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1
                              ),
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(int.parse(widget.foodcard.time), (int index){
                                  return const Icon(Icons.schedule, size: 10);
                                }),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(int.parse(widget.foodcard.waterneed), (int index){
                                  return const Icon(Icons.water_drop_outlined, size: 10);
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Text(
                              widget.foodcard.description, // MODIFIED
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 10.5,
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
                    top: 70,
                  ),
                  child: InkWell(
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
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 20,
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
