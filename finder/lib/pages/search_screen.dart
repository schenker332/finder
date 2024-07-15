import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Data/foodcard.dart';
import '../Data/given_recipes.dart';

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
    "Vegan", "Vegetarisch", "Nudeln", "Günstig", "Hühnchen",
    "Reis", "Fleisch"
  ];

  @override
  void initState() {
    super.initState();
    loadFoodcards();
  }

  Future<void> loadFoodcards() async {

    //final String response = await rootBundle.loadString('assets/given_recipes.json');
    final data = await json.decode(given_recipes);
    List<dynamic> recipes = data['recipes'];
    for (var x in data['recipes']) {
      print(x);
      print("ob");
      allFoodcards.add(Foodcard.fromJson(x));
    }

    print(allFoodcards.length);
    setState(() {

    });

  }

  void filterFoodcards(String query) {
    setState(() {
      filteredFoodcards = allFoodcards.where((foodcard) {
        return foodcard.title.toLowerCase().contains(query.toLowerCase()) ||
            foodcard.description.toLowerCase().contains(query.toLowerCase()) ||
            foodcard.foodart.toLowerCase().contains(query.toLowerCase()) ||
            foodcard.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())) ||
            foodcard.ingredients.any((ingredient) =>
                ingredient.any((element) => element.toString().toLowerCase().contains(query.toLowerCase())));
      }).toList();
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    "F", // Initialien
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                onChanged: (query) => filterFoodcards(query),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: popularTags.map((tag) {
                  return GestureDetector(
                    onTap: () {
                      searchController.text = tag;
                      filterFoodcards(tag);
                    },
                    child: Chip(
                      label: Text(tag),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: filteredFoodcards.isNotEmpty
                    ? ListView.builder(
                  itemCount: filteredFoodcards.length,
                  itemBuilder: (context, index) {
                    return FoodcardWidget(foodcard: filteredFoodcards[index]);
                  },
                )
                    : Center(
                  child: Text(
                    'Keine Rezepte gefunden',
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

class FoodcardWidget extends StatelessWidget {
  final Foodcard foodcard;

  const FoodcardWidget({required this.foodcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                foodcard.imageURL,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodcard.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    foodcard.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(foodcard.foodart),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      // Add more icons or information as needed
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}