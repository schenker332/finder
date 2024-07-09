import 'package:finder/einkaufsliste.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'food_card.dart';
import 'fooditems.dart';
import 'einkaufsliste.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.afacad(
            fontSize: 32,
            color: Colors.black,

          )
        )
      ),
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Food App'),
        ),*/
        body: Einkaufsliste(
          
        ),

    /*ListView.builder(
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
        ), */
      ),
    );
  }
}


