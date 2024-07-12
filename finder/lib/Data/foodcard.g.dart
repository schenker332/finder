// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Foodcard _$FoodcardFromJson(Map<String, dynamic> json) {
  return Foodcard(
      id: json['id'] as String,
      title: json['title'] as String,
      imageURL: json['imageURL'] as String,
      price: json['price'] as String,
      foodart: json['foodart'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      waterneed: json['waterneed'] as String,
      portion: json['portion'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as List<dynamic>)
          .toList(),
      preparation: (json['preparation'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      kommentar: json['Kommentar'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),

);
}

Map<String, dynamic> _$FoodcardToJson(Foodcard instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageURL': instance.imageURL,
      'price': instance.price,
      'foodart': instance.foodart,
      'description': instance.description,
      'time': instance.time,
      'waterneed': instance.waterneed,
      'portion': instance.portion,
      'ingredients': instance.ingredients,
      'preparation': instance.preparation,
      'kommentar': instance.kommentar,
      'tags': instance.tags,

};
