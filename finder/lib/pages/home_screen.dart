import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/ingredientcard.dart';
import 'package:foodfinder_app/Widgets/foodcard_design.dart';
import 'package:foodfinder_app/Widgets/ingredientcard_design.dart';
import '../Data/foodcard.dart';
import 'plan_screen.dart';
import '../Data/foodcard_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Foodcard> allcards = [];
  List<Ingredientcard> allingredients = [];
  final FoodcardStorage storage = FoodcardStorage();

  @override
  void initState() {
    super.initState();
    _loadFoodcards();
  }

  Future<void> _loadFoodcards() async {
    List<Foodcard> loadedCards = await storage.getFoodcards();
    List<Ingredientcard> loadedIngredients = await storage.getIngredients();

    setState(() {
      allcards = loadedCards;
      allingredients = loadedIngredients;
    });
  }

  Future<void> _addNewFoodcard(Foodcard newCard) async {
    setState(() {
      allcards.add(newCard);
    });
    await storage.saveFoodcards(allcards);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hallo Franziska!", // Username Nutzername
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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Wochenplan",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlanScreen()),
                      );
                    },
                    child: const Icon(CupertinoIcons.arrow_right),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: allcards.map((oneCard) => FoodcardDesign(foodcard: oneCard)).toList(),
              ),
            ),
            Center(
              child: Container(
                width: 118,
                height: 17,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 5; i++)
                      const Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 9,
                      ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Oben auf deiner Liste",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlanScreen()),
                      );
                    },
                    child: const Icon(CupertinoIcons.arrow_right),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child: ListView(
                children: allingredients.map((oneCard) => IngredientcardDesign(ingredientcard: oneCard)).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "Zuletzt Gespeichert",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlanScreen()),
                      );
                    },
                    child: const Icon(CupertinoIcons.arrow_right),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: allcards.map((oneCard) => FoodcardDesign(foodcard: oneCard)).toList(),
              ),
            ),
          ],
        ),
        ),

    );
  }
}
