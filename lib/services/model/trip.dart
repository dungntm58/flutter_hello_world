import 'package:flutter/material.dart';

@immutable
class TripModel {
  final String? name;
  final String? image;
  final int price;
  final int people;
  final int selectedPeople;
  final int stars;
  final String? description;
  final String? location;

  TripModel({
    required this.name,
    required this.image,
    required this.price,
    required this.people,
    required this.selectedPeople,
    required this.stars,
    required this.description,
    required this.location,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      name: json['name'] as String?,
      image: json['img'] as String?,
      price: json['price'] as int? ?? 0,
      people: json['people'] as int? ?? 0,
      selectedPeople: json['selected_people'] as int? ?? 0,
      stars: json['stars'] as int? ?? 0,
      description: json['description'] as String?,
      location: json['location'] as String?,
    );
  }

  String? get imagePath {
    if (image == null) {
      return null;
    }
    return 'http://mark.bslmeiyu.com/uploads/$image';
  }
}
