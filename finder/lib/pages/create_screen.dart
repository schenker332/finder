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
//Alle Eigenschaften des Rezept die Gespeichert werden sollen, werden inizialisiert
class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController foodartController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController waterneedController = TextEditingController();
  final FoodcardStorage storage = FoodcardStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Ist der Header für die Gespeichert-Seite mit dem Namen der Seite und den Initialien des Nutzers
        appBar: AppBar(
          title: Text(
            "Erstellen", // Name der Seite
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
        //Erstellt die UI für die Erstellen-Seite mit den Textfeldern für die Eingabe der Daten. Allerdings muss es noch schön gemacht werden
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: imageURLController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: foodartController,
                  decoration: InputDecoration(labelText: 'Food Art'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                ),
                TextField(
                  controller: waterneedController,
                  decoration: InputDecoration(labelText: 'Water Need'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveFoodcard,
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Funktion zum Speichern der Daten, nachdem alle Daten eingegeben wurden. Wird ausgeführt, wenn der Button "Save" gedrückt wird
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
    );

    List<Foodcard> existingCards = await storage.getFoodcards();
    existingCards.add(newCard);
    await storage.saveFoodcards(existingCards);

    // Navigate back or show a success message
    Navigator.of(context).pop();
  }
}
