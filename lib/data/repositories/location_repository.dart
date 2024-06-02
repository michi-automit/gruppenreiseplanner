import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/location_model.dart';
import '../models/category_model.dart';

class LocationRepository {
  Future<List<Location>> fetchLocations() async {
    try {
      final response = await rootBundle.loadString('assets/locations.json');
      return Location.fromJsonList(response);
    } catch (e) {
      print('Error loading locations: $e');
      rethrow;
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await rootBundle.loadString('assets/categories.json');
      return Category.fromJsonList(response);
    } catch (e) {
      print('Error loading categories: $e');
      rethrow;
    }
  }
}
