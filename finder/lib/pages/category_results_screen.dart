import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/card.dart';

class CategoryResultsScreen extends StatelessWidget {
  final String category;
  final List<Cardbox> results;

  const CategoryResultsScreen({
    Key? key,
    required this.category,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final card = results[index];
          return ListTile(
            title: Text(card.title),
            subtitle: Text(card.description),
            leading: Image.network(card.imageURL, width: 50, height: 50, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
