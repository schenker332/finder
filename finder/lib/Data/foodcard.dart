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

  const Foodcard({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.price,
    required this.foodart,
    required this.description,
    required this.time,
    required this.waterneed,
  });

  factory Foodcard.fromJson(Map<String, dynamic> json) => _$FoodcardFromJson(json);
  Map<String, dynamic> toJson() => _$FoodcardToJson(this);
}
