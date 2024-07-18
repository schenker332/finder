import 'dart:convert';
import 'dart:math';
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
    List<int> randomIndices = [];
    if (filteredFoodcards.isNotEmpty) {
      Random random = Random();
      Set<int> chosenIndices = {};

      while (chosenIndices.length < min(3, filteredFoodcards.length)) {
        int randomIndex = random.nextInt(filteredFoodcards.length);
        if (!chosenIndices.contains(randomIndex)) {
          chosenIndices.add(randomIndex);
        }
      }

      randomIndices = chosenIndices.toList();
    }

    // Generate widgets based on the randomly chosen indices
    List<Widget> foodCardWidgets = randomIndices.map((index) {
      return FoodcardDesign(foodcard: filteredFoodcards[index]);
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Padding(
            padding: EdgeInsets.only(left: 8, top: 18, bottom: 12),
            child: Text(
              "Suche",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Beliebt",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Ändere die Schriftgröße nach Bedarf
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: popularTags.map((tag) {
                          return GestureDetector(
                            onTap: () {
                              searchController.text = tag;
                              filterFoodcards(tag);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary, // Gelbe Hintergrundfarbe
                                borderRadius: BorderRadius.all(Radius.circular(99)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                child: Text(
                                  tag,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      if (filteredFoodcards.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            filteredFoodcards == allFoodcards ? "Vorschläge" : "Ergebnisse",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      if(filteredFoodcards.isNotEmpty && filteredFoodcards == allFoodcards) ...foodCardWidgets
                      else if(filteredFoodcards.isNotEmpty) ...List.generate(filteredFoodcards.length, (int index){
                        return FoodcardDesign(foodcard: filteredFoodcards[index]);
                      })
                      else Center(
                        child: Text(
                          'Keine Rezepte gefunden',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
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
