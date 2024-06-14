import 'package:flutter/material.dart';
import 'food_card.dart';
import 'fooditems.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food App'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: foodItems.length,
          itemBuilder: (context, index) {
            final foodItem = foodItems[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              height: 300, // Setze die Höhe der Karte auf 300 Pixel
              child: FoodCard(
                title: foodItem.title,
                imagePath: foodItem.imagePath,
                isVegan: foodItem.isVegan,
                price: foodItem.price,
                description: foodItem.description,
                availability: foodItem.availability,
              ),
            );
          },
        ),
      ),
    );
  }
}
