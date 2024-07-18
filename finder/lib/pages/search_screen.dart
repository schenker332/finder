import 'package:flutter/material.dart';
import 'package:foodfinder_app/Data/Data.dart';
import 'package:foodfinder_app/Data/card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Cardbox> searchResults = [];
  List<Map<String, String>> categories = [
    {"name": "Fleisch", "image": "lib/assets/Fleisch.png"},
    {"name": "Vegan", "image": "lib/assets/nudeln_mit_walnuessen.png"},
    {"name": "Günstig", "image": "lib/assets/pizza-7863713_1280.jpg"},
    // Weitere Kategorien hier hinzufügen
  ];

  void searchDatabase(String query) {
    final results = allCards.where((card) {
      final titleLower = card.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  void filterByCategory(String category) {
    final results = allCards.where((card) {
      final categoryLower = category.toLowerCase();
      final cardFoodArtLower = card.foodart.toLowerCase();

      return cardFoodArtLower.contains(categoryLower);
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  void initState() {
    super.initState();
    searchResults = allCards;  // Initialisiere die Suchergebnisse mit allen Karten
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Suche",
            style: Theme.of(context).textTheme.titleLarge,
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
                    "F",
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      searchDatabase(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Suche nach Rezepten...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      filterByCategory(category["name"]!);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: AssetImage(category["image"]!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category["name"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final card = searchResults[index];
                  return ListTile(
                    title: Text(card.title),
                    subtitle: Text(card.description),
                    leading: Image.network(card.imageURL, width: 50, height: 50, fit: BoxFit.cover),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
