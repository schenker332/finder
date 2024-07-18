import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Data/foodcard.dart';
import '../Data/given_recipes.dart';
import '../Widgets/foodcard_design.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Foodcard> allFoodcards = [];
  List<Foodcard> filteredFoodcards = [];
  List<String> popularTags = [
    "Vegan", "Veggie", "Nudeln", "Reis", "Fleisch", "Salat"
  ];

  @override
  void initState() {
    super.initState();
    loadFoodcards();
  }

  Future<void> loadFoodcards() async {
    final data = await json.decode(given_recipes);
    List<dynamic> recipes = data['recipes'];
    for (var x in recipes) {
      allFoodcards.add(Foodcard.fromJson(x));
    }

    setState(() {
      filteredFoodcards = allFoodcards;
    });
  }

  void filterFoodcards(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFoodcards = allFoodcards;
      } else {
        filteredFoodcards = allFoodcards.where((foodcard) {
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
          title: Text(
            "Suche",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Was willst Du heute essen?',
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
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Beliebt",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22, // Ändere die Schriftgröße nach Bedarf
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: popularTags.map((tag) {
                          return GestureDetector(
                            onTap: () {
                              searchController.text = tag;
                              filterFoodcards(tag);
                            },
                            child: Chip(
                              label: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.onPrimary, // Gelbe Hintergrundfarbe
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      if (filteredFoodcards.isNotEmpty)
                        Text(
                          "Vorschläge",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28, // Ändere die Schriftgröße nach Bedarf
                          ),
                        ),
                      SizedBox(height: 10),
                      ...List.generate(filteredFoodcards.isNotEmpty ? filteredFoodcards.length : 1, (int index){
                        if(filteredFoodcards.isNotEmpty){
                          return FoodcardDesign(foodcard: filteredFoodcards[index]);
                        }else{
                          return Center(
                            child: Text(
                              'Keine Rezepte gefunden',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          );
                        }
                      }),
                      const SizedBox(
                        height: 75,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
