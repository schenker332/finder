import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'foodcard.dart';
import 'ingredientcard.dart';

class FoodcardStorage {
  static const String _keyFoodcards = 'foodcards';
  static const String _keyIngredients = 'ingredients';
  static const String _isLikedKey = "isLiked";

  Future<void> saveFoodcards(List<Foodcard> foodcards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> foodcardsJson = foodcards.map((foodcard) => jsonEncode(foodcard.toJson())).toList();
    await prefs.setStringList(_keyFoodcards, foodcardsJson);
  }

  Future<void> saveIngredients(List<Ingredientcard> ingredients) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ingredientsJson = ingredients.map((ingredient) => jsonEncode(ingredient.toJson())).toList();
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

  Future<List<Foodcard>> getLikedRecipes(List<Foodcard> allFoodCards) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedIds = prefs.getStringList(_isLikedKey) ?? [];
    List<Foodcard> result = [];
    for(int i = 0; i < allFoodCards.length; i++){
      if(likedIds.contains(allFoodCards[i].id)){
        result.add(allFoodCards[i]);
      }
    }
    return result;
  }

  Future<List<String>> getLikedRecipeIds() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedIds = prefs.getStringList(_isLikedKey) ?? [];
    return likedIds;
  }

  Future<void> likeRecipe(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedIds = prefs.getStringList(_isLikedKey) ?? [];
    likedIds.add(id);
    await prefs.setStringList(_isLikedKey, likedIds);
  }

  Future<void> unlikeRecipe(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedIds = prefs.getStringList(_isLikedKey) ?? [];
    likedIds.remove(id);
    await prefs.setStringList(_isLikedKey, likedIds);
  }

}
