import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'foodcard.dart';
import 'ingredientcard.dart';

class FoodcardStorage {
  static const String _keyFoodcards = 'foodcards';
  static const String _keyIngredients = 'ingredients';

  Future<void> saveFoodcards(List<Foodcard> foodcards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> foodcardsJson = foodcards.map((foodcard) => jsonEncode(foodcard.toJson())).toList();
    //print(foodcardsJson[0]);
    await prefs.setStringList(_keyFoodcards, foodcardsJson);
  }

  Future<void> saveIngredients(List<Ingredientcard> ingredients) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ingredientsJson = ingredients.map((ingredient) => jsonEncode(ingredient.toJson())).toList();
    //print(ingredientsJson[0]);
    await prefs.setStringList(_keyIngredients, ingredientsJson);
  }

  Future<List<Foodcard>> getFoodcards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? foodcardsJson = prefs.getStringList(_keyFoodcards);
    if (foodcardsJson != null) {
      return foodcardsJson.map((jsonString) => Foodcard.fromJson(jsonDecode(jsonString))).toList();
    } else {
      return [];
    }
  }

  Future<List<Ingredientcard>> getIngredients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? ingredientsJson = prefs.getStringList(_keyIngredients);
    if (ingredientsJson != null) {
      return ingredientsJson.map((jsonString) => Ingredientcard.fromJson(jsonDecode(jsonString))).toList();
    } else {
      return [];
    }
  }
}
