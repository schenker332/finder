import 'package:json_annotation/json_annotation.dart';

part 'foodcard.g.dart';

@JsonSerializable()
class Foodcard {
  final String id;
  final String title;
  final String imageURL;
  final String price;
  final String foodart;
  final String description;
  final String time;
  final String waterneed;
  final String portion;
  final List<List<dynamic>> ingredients;
  final List<String> preparation;
  final String kommentar;
  final List<String> tags;

  const Foodcard({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.price,
    required this.foodart,
    required this.description,
    required this.time,
    required this.waterneed,
    required this.portion,
    required this.ingredients,
    required this.preparation,
    required this.kommentar,
    required this.tags,
  });

  factory Foodcard.fromJson(Map<String, dynamic> json) => _$FoodcardFromJson(json);
  Map<String, dynamic> toJson() => _$FoodcardToJson(this);
}
