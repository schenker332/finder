import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isVegan;
  final double price;
  final String description;
  final String availability;

  FoodCard({
    required this.title,
    required this.imagePath,
    required this.isVegan,
    required this.price,
    required this.description,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.asset(
              imagePath, // Verwende den übergebenen Bildpfad
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, // Verwende den übergebenen Titel
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        if (isVegan)
                          Chip(
                            label: Text('vegan'),
                            backgroundColor: Colors.green[100],
                          ),
                        Spacer(),
                        ...List.generate(price.round().clamp(0, 3), (index) => Icon(Icons.euro, size: 20)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 20),
                        SizedBox(width: 5),
                        Icon(Icons.water_drop_outlined, size: 20),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      description, // Verwende die übergebene Beschreibung
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      availability, // Verwende die übergebene Verfügbarkeit
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
