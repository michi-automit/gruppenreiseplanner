import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/search_page.dart';
import '../../data/models/location_model.dart';
import '../pages/details_page.dart';
import '../pages/trips_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchPage());
      case '/details':
        final location = settings.arguments as Location;
        return MaterialPageRoute(
            builder: (_) => DetailsPage(location: location));
      case '/trips':
        return MaterialPageRoute(builder: (_) => TripsPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
