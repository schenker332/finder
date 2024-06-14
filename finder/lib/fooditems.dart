

class FoodItem {
  final String title;
  final String imagePath;
  final bool isVegan;
  final double price;
  final String description;
  final String availability;

  FoodItem({
    required this.title,
    required this.imagePath,
    required this.isVegan,
    required this.price,
    required this.description,
    required this.availability,
  });
}

List<FoodItem> foodItems = [
  FoodItem(
    title: 'Nudeln mit Walnüssen',
    imagePath: 'lib/assets/nudeln_mit_walnuessen.png',
    isVegan: true,
    price: 3.5,
    description: 'Der frische und gesunde Klassiker für den schnellen Genuss.',
    availability: 'Heute',
  ),
  FoodItem(
    title: 'Nudeln',
    imagePath: 'lib/assets/nudeln_mit_walnuessen.png',
    isVegan: true,
    price: 6,
    description: 'iker für den schnellen Genuss.',
    availability: 'Heute',
  ),
  // Weitere Gerichte hier hinzufügen
];


