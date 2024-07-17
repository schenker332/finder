import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/ingredientcard.dart';
import 'package:foodfinder_app/Widgets/foodcard_design.dart';
import 'package:foodfinder_app/Data/foodcard.dart';
import 'package:foodfinder_app/Data/foodcard_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NeuesProdukt.dart';
import 'plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Foodcard> allcards = [];
  List<Ingredientcard> allingredients = [];
  List<String> topThreeItems = [];
  final FoodcardStorage storage = FoodcardStorage();

  @override
  void initState() {
    super.initState();
    _loadFoodcards();
    _loadTopThreeItems();
  }

  Future<void> _loadFoodcards() async {
    List<Foodcard> loadedCards = await storage.getFoodcards();
    List<Ingredientcard> loadedIngredients = await storage.getIngredients();

    setState(() {
      allcards = loadedCards;
      allingredients = loadedIngredients;
    });
  }

  Future<void> _loadTopThreeItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('SavedList') ?? [];
    print("Loaded items: $items");

    setState(() {
      topThreeItems = items.take(10).toList();
      print("Top three items: $topThreeItems");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Willkommen!", // Username Nutzername
            style: Theme.of(context).textTheme.titleLarge!.copyWith(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 18),
              //       child: Text(
              //         "Wochenplan",
              //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //           fontSize: 20,
              //           letterSpacing: 1,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 15),
              //       child: GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => const PlanScreen()),
              //           );
              //         },
              //         child: const Icon(CupertinoIcons.arrow_right),
              //       ),
              //     ),
              //   ],
              // ),
              // Expanded(
              //   flex: 3,
              //   child: PageView(
              //     scrollDirection: Axis.horizontal,
              //     children: allcards.map((oneCard) => FoodcardDesign(foodcard: oneCard)).toList(),
              //   ),
              // ),
              // Center(
              //   child: Container(
              //     width: 118,
              //     height: 17,
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).colorScheme.primary,
              //       borderRadius: BorderRadius.circular(17),
              //       border: Border.all(
              //         color: Colors.black,
              //         width: 1,
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         for (int i = 0; i < 5; i++)
              //           const Icon(
              //             Icons.circle,
              //             color: Colors.grey,
              //             size: 9,
              //           ),
              //       ],
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      bottom: 10,
                      top: 20,
                    ),
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
                          MaterialPageRoute(builder: (context) => const PlanScreen()),
                        );
                      },
                      child: const Icon(CupertinoIcons.arrow_right),
                    ),
                  ),
                ],
              ),
              ...topThreeItems.map((item){
                List<String> details = item.split(', ');
                print("Items details: $details");
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Neuesprodukt(
                    Produktname: details[0],
                    Menge: details[1],
                    Abgehakt: details[2] == 'Gekauft',
                    stelle: topThreeItems.indexOf(item),
                    isInteractive: true,
                    onSave: (){

                    },
                  ),
                );
              }).take(5).toList(),
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
                          MaterialPageRoute(builder: (context) => const PlanScreen()),
                        );
                      },
                      child: const Icon(CupertinoIcons.arrow_right),
                    ),
                  ),
                ],
              ),
              //Expanded(
              //  flex: 3,
              //  child: ListView(
              //    children: allcards.map((oneCard) => FoodcardDesign(foodcard: oneCard)).toList(),
              //  ),
              //),
            ],
          ),
        ),
        ),

    );
  }
}
