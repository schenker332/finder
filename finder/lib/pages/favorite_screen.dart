import 'package:flutter/material.dart';
import '../Data/foodcard.dart';
import '../Data/foodcard_storage.dart';
import '../Widgets/foodcard_design.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Foodcard> favoriteCards = [];
  final FoodcardStorage storage = FoodcardStorage();

  @override
  void initState() {
    super.initState();
    _loadFavoriteCards();
  }

  Future<void> _loadFavoriteCards() async {
    List<Foodcard> loadedCards = await storage.getFoodcards();
    setState(() {
      favoriteCards = loadedCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Gespeichert", // Username Nutzername
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
        body: favoriteCards.isEmpty
            ? Center(child: Text("Keine gespeicherten Foodcards"))
            : ListView.builder(
          itemCount: favoriteCards.length,
          itemBuilder: (context, index) {
            return FoodcardDesign(foodcard: favoriteCards[index]);
          },
        ),
      ),
    );
  }
}
