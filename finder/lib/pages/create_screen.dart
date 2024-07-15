import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Data/foodcard.dart';
import '../Data/foodcard_storage.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController foodartController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController waterneedController = TextEditingController();
  final TextEditingController portionController = TextEditingController();
  final TextEditingController kommentarController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  List<List<dynamic>> ingredients = [];
  List<String> preparation = [];
  List<String> tags = [];

  final FoodcardStorage storage = FoodcardStorage();
  bool left = true;
  bool right = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Erstellen", // Username Nutzername
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
            bottom: TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 2,
              dividerColor: Color(0xFFFFFBF9),
              tabs: [
                Tab(
                  child: Text(
                    "Mein Rezept",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "KI Rezept",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 124,
                              height: 124,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.add_circled,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: 140,
                                      height: 20,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: TextFormField(
                                          controller: imageURLController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              labelText: 'Bild hinzufügen',
                                              labelStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  child: TextFormField(
                                    controller: titleController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Titel",
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        controller: descriptionController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Mein tolles Essen...',
                                            labelStyle: TextStyle(
                                                color: Colors.grey)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      tags.add(tagsController.text);
                                      tagsController.clear();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimary,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  icon: Icon(
                                    CupertinoIcons.add_circled,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  label: Text("Tags hinzufügen"),
                                ),
                                TextFormField(
                                  controller: tagsController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Tags',
                                      labelStyle: TextStyle(
                                          color: Colors.grey)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "Zutaten",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            fontSize: 22,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    for (var ingredient in ingredients)
                      ListTile(
                        title: Text(ingredient.join(", ")),
                      ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              width: 220,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Zutat',
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  onFieldSubmitted: (value) {
                                    ingredients.add([value]);
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Menge',
                                      labelStyle: TextStyle(
                                          color: Colors.grey)),
                                  onFieldSubmitted: (value) {
                                    if (ingredients.isNotEmpty) {
                                      ingredients.last.add(value);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15),
                            child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Stk.',
                                      labelStyle: TextStyle(
                                          color: Colors.grey)),
                                  onFieldSubmitted: (value) {
                                    if (ingredients.isNotEmpty) {
                                      ingredients.last.add(value);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            ingredients.add([]);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onPrimary,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.add_circled,
                          size: 20,
                          color: Colors.black,
                        ),
                        label: const Text("Zutat"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "Zubereitung",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            fontSize: 22,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    for (var step in preparation)
                      ListTile(
                        title: Text(step),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Was ist zu tun?',
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            onFieldSubmitted: (value) {
                              preparation.add(value);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 15),
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: _saveFoodcard,
                        child: const Text("Speichern"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 50, left: 20, right: 20 ),
                    alignment: Alignment.center,
                    child: Text(
                      "Lassen Sie sich von unserem intelligenten Assistenten inspirieren und erstellen Sie innerhalb von Sekunden das perfekte Rezept für jeden Anlass!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://th.bing.com/th/id/OIP.bciqySzv3orDFP18wQ1YsQHaE8?rs=1&pid=ImgDetMain",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Welche Zutaten hast Du noch...',
                              labelStyle: TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveFoodcard() async {
    final newCard = Foodcard(
      id: DateTime.now().toString(), // Generate a unique ID
      title: titleController.text,
      imageURL: imageURLController.text,
      price: priceController.text,
      foodart: foodartController.text,
      description: descriptionController.text,
      time: timeController.text,
      waterneed: waterneedController.text,
      portion: portionController.text,
      ingredients: ingredients,
      preparation: preparation,
      kommentar: kommentarController.text,
      tags: tags,

    );

    List<Foodcard> existingCards = await storage.getFoodcards();
    existingCards.add(newCard);
    await storage.saveFoodcards(existingCards);

    // Navigate back or show a success message
    Navigator.of(context).pop();
  }
}
