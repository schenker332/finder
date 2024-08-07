import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/ingredientcard.dart';
import 'package:foodfinder_app/Widgets/foodcard_design.dart';
import 'package:foodfinder_app/Data/foodcard.dart';
import 'package:foodfinder_app/Data/foodcard_storage.dart';
import 'package:foodfinder_app/main.dart';
import 'package:foodfinder_app/pages/favorite_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/given_recipes.dart';
import 'NeuesProdukt.dart';
import 'plan_screen.dart';

/*
Was gibt es zutun:
- Liken von Rezepten + Anzeigen der Rezepte auf der "Gespeichert"-Seite
- Anlegen von Rezepten
 */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Foodcard> allcards = [], allFoodcards = [];
  List<Ingredientcard> allingredients = [];
  List<String> topThreeItems = [];
  final FoodcardStorage storage = FoodcardStorage();
  Foodcard? recentlyLiked;

  @override
  void initState() {
    super.initState();
    _loadFoodcards();
    _loadTopThreeItems();
    Future.delayed(const Duration(milliseconds: 0)).then((_){
      _loadTopThreeItems();
    });
  }

  Future<void> _loadFoodcards() async {
    List<Foodcard> loadedCards = await storage.getFoodcards();
    List<Ingredientcard> loadedIngredients = await storage.getIngredients();

    String recipeKey = "RECIPES";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> savedRecipes = sharedPreferences.getStringList(recipeKey) ?? [];
    final data = await json.decode(given_recipes);
    List<dynamic> recipes = data['recipes'];
    for(int i = 0; i < savedRecipes.length; i++){
      recipes.add(json.decode(savedRecipes[i]));
    }
    for (var x in recipes) {
      allFoodcards.add(Foodcard.fromJson(x));
    }

    List<String> likedIds = await FoodcardStorage().getLikedRecipeIds();

    if(likedIds.isNotEmpty){
      for(int i = 0; i < allFoodcards.length; i++){
        if(allFoodcards[i].id == likedIds.last){
          recentlyLiked = allFoodcards[i];
          break;
        }
      }
    }

    setState(() {
      allcards = loadedCards;
      allingredients = loadedIngredients;
    });
  }

  Future<void> _loadTopThreeItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('SavedList') ?? [];
    // print("Loaded items: $items");

    setState(() {
      topThreeItems = items.take(10).toList();
      // print("Top three items: $topThreeItems");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 8.0,
          shadowColor: const Color(0xFFFFFBF9),
          surfaceTintColor: const Color(0xFFFFFBF9),
          title: Padding(
            padding: EdgeInsets.only(left: 8, top: 18, bottom: 12),
            child: Text(
              "Willkommen!", // Username Nutzername
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                if(!topThreeItems.isEmpty) Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 14,
                        bottom: 10,
                        top: 20
                      ),
                      child: Text(
                        "Oben auf deiner Liste",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10,
                          top: 20
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => MyFirstApp(currentPage: 3),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                            (route) => false,
                          );
                        },
                        child: const Icon(CupertinoIcons.arrow_right),
                      ),
                    ),
                  ],
                )
                else SizedBox(),
                if(!topThreeItems.isEmpty) ...topThreeItems.map((item){
                  List<String> details = item.split(', ');
                  // print("Items details: $details");
                  return Neuesprodukt(
                    Produktname: details[0],
                    Menge: details[1],
                    Abgehakt: details[2] == 'Gekauft',
                    stelle: topThreeItems.indexOf(item),
                    isInteractive: true,
                    onSave: (){},
                  );
                }).take(5).toList()
                else SizedBox(),
                recentlyLiked != null ? Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    top: !topThreeItems.isEmpty ? 20 : 0
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: Text(
                          "Zuletzt Gespeichert",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => MyFirstApp(currentPage: 4),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                            (route) => false,
                          );
                        },
                        child: const Icon(CupertinoIcons.arrow_right),
                      ),
                    ],
                  ),
                ) : const SizedBox(),
                recentlyLiked != null ? FoodcardDesign(foodcard: recentlyLiked!) : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 14,
                          bottom: 10,
                          top: recentlyLiked != null ? 20 : 0
                      ),
                      child: Text(
                        "Vorschläge für Dich",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10,
                          top: recentlyLiked != null ? 20 : 0
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => MyFirstApp(currentPage: 1),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                            (route) => false,
                          );
                        },
                        child: const Icon(CupertinoIcons.arrow_right),
                      ),
                    ),
                  ],
                ),
                ...List.generate(allFoodcards.length, (int index){
                  return FoodcardDesign(foodcard: allFoodcards[index]);
                }),
                const SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ),
        ),

    );
  }
}
