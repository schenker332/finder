import 'package:json_annotation/json_annotation.dart';

part 'ingredientcard.g.dart';

@JsonSerializable()
class Ingredientcard {
  final String id;
  final String ingredientname;
  final String ingredientcount;

  const Ingredientcard({
    required this.id,
    required this.ingredientname,
    required this.ingredientcount,
  });

  factory Ingredientcard.fromJson(Map<String, dynamic> json) => _$IngredientcardFromJson(json);

  get name => null;

  get quantity => null;

  get bought => null;
  Map<String, dynamic> toJson() => _$IngredientcardToJson(this);
}
