import 'package:flutter/material.dart';

IconData getIconData(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case 'restaurant':
      return Icons.restaurant;
    case 'strand':
      return Icons.beach_access;
    case 'museum':
      return Icons.museum;
    case 'park':
      return Icons.park;
    case 'einkaufen':
      return Icons.shopping_bag;
    default:
      return Icons.place;
  }
}
