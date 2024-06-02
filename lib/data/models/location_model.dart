import 'dart:convert';

import 'package:flutter/foundation.dart';

class OpeningHours {
  final String day;
  final String opening;
  final String closing;

  OpeningHours(
      {required this.day, required this.opening, required this.closing});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      day: json['day'] ?? '',
      opening: json['opening'] ?? '',
      closing: json['closing'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'opening': opening,
      'closing': closing,
    };
  }
}

class Location {
  final String id;
  final String name;
  final String address;
  final List<String> categories;
  final String description;
  final String image;
  final List<OpeningHours> openingHours; // Neues Feld für Öffnungszeiten

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.categories,
    required this.description,
    required this.image,
    required this.openingHours, // Initialisieren Sie das neue Feld
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      openingHours: json['openingHours'] != null
          ? (json['openingHours'] as List)
              .map((item) => OpeningHours.fromJson(item))
              .toList()
          : [],
    );
  }

  static List<Location> fromJsonList(String jsonString) {
    final data = json.decode(jsonString) as List;
    return data.map((item) => Location.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'categories': categories,
      'description': description,
      'image': image,
      'openingHours': openingHours
          .map((e) => e.toJson())
          .toList(), // Fügen Sie das neue Feld zur JSON-Konvertierung hinzu
    };
  }
   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
      other.id == id &&
      other.name == name &&
      other.address == address &&
      other.image == image &&
      listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      image.hashCode ^
      categories.hashCode;
  }
}
