import 'package:flutter/material.dart';
import '../Data/foodcard.dart';
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
    List<Foodcard> allFoodcards = await foodcardStorage.getFoodcards();
    List<Foodcard> liked = await foodcardStorage.getLikedRecipes(allFoodcards);
    setState(() {
      likedFoodcards = liked;
      filteredFoodcards = liked;
    });
  }

  void filterFoodcards(String query) {
    setState(() {
      filteredFoodcards = likedFoodcards.where((foodcard) {
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
            "Gespeichert", //Username Nutzername
            style: Theme.of(context).textTheme.titleLarge!.copyWith(),
          ),
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
                  hintText: 'Gespeicherte Rezepte durchsuchen',
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
              Expanded(
                child: filteredFoodcards.isNotEmpty
                    ? ListView.builder(
                  itemCount: filteredFoodcards.length,
                  itemBuilder: (context, index) {
                    return FoodcardDesign(
                      foodcard: filteredFoodcards[index],
                    );
                  },
                )
                    : Center(
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
