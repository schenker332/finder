import 'dart:convert';

import 'package:flutter/material.dart';
import '../Data/foodcard.dart';
import '../Data/given_recipes.dart';
import '../Widgets/foodcard_design.dart';
import '../Data/foodcard_storage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Foodcard> likedFoodcards = [];
  List<Foodcard> filteredFoodcards = [];
  final FoodcardStorage foodcardStorage = FoodcardStorage();

  @override
  void initState() {
    super.initState();
    loadLikedFoodcards();
  }

  Future<void> loadLikedFoodcards() async {
    List<Foodcard> allFoodcards = [];
    final data = await json.decode(given_recipes);
    List<dynamic> recipes = data['recipes'];
    for (var x in recipes) {
      allFoodcards.add(Foodcard.fromJson(x));
    }
    List<Foodcard> liked = await foodcardStorage.getLikedRecipes(allFoodcards);
    setState(() {
      likedFoodcards = liked;
      filteredFoodcards = liked;
    });
  }

  void filterFoodcards(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFoodcards = likedFoodcards;
      } else {
        filteredFoodcards = likedFoodcards.where((foodcard) {
          return foodcard.title.toLowerCase().contains(query.toLowerCase()) ||
              foodcard.description.toLowerCase().contains(query.toLowerCase()) ||
              foodcard.foodart.toLowerCase().contains(query.toLowerCase()) ||
              foodcard.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())) ||
              foodcard.ingredients.any((ingredient) =>
                  ingredient.any((element) => element.toString().toLowerCase().contains(query.toLowerCase())));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text(
            "Gespeichert", //Username Nutzername
            style: Theme.of(context).textTheme.titleLarge!.copyWith(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: TextField(
                  controller: searchController,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                  ),
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black,),
                    hintText: 'Was willst Du heute essen?',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black), // Schwarze Umrandung
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black), // Schwarze Umrandung
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black), // Schwarze Umrandung
                    ),
                    filled: true,
                    fillColor: Colors.white,  // Hintergrundfarbe auf weiß gesetzt
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (query) => filterFoodcards(query),
                ),
              ),
              Expanded(
                child: filteredFoodcards.isNotEmpty ? ListView.builder(
                  itemCount: filteredFoodcards.length,
                  itemBuilder: (context, index) {
                    bool isLastItem = index == filteredFoodcards.length - 1 && filteredFoodcards.isNotEmpty;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLastItem ? 85.0 : 0),
                      child: FoodcardDesign(
                        foodcard: filteredFoodcards[index],
                      ),
                    );
                  },
                ) : Center(
                  child: Text(
                    'Bisher keine Rezepte vorhanden',
                    style: Theme.of(context).textTheme.titleLarge,
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
