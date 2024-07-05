// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foodcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Foodcard _$FoodcardFromJson(Map<String, dynamic> json) => Foodcard(
      id: json['id'] as String,
      title: json['title'] as String,
      imageURL: json['imageURL'] as String,
      price: json['price'] as String,
      foodart: json['foodart'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      waterneed: json['waterneed'] as String,
    );

Map<String, dynamic> _$FoodcardToJson(Foodcard instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageURL': instance.imageURL,
      'price': instance.price,
      'foodart': instance.foodart,
      'description': instance.description,
      'time': instance.time,
      'waterneed': instance.waterneed,
    };
