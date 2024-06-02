import 'location_model.dart';

class Trip {
  final String name;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final List<Location> locations; // Hinzugefügtes Feld für Locations

  Trip({
    required this.name,
    required this.arrivalDate,
    required this.departureDate,
    this.locations = const [], // Initialisieren Sie das neue Feld
  });

  Trip copyWith({List<Location>? locations}) {
    return Trip(
      name: name,
      arrivalDate: arrivalDate,
      departureDate: departureDate,
      locations: locations ?? this.locations,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      name: json['name'],
      arrivalDate: DateTime.parse(json['arrivalDate']),
      departureDate: DateTime.parse(json['departureDate']),
      locations: (json['locations'] as List)
          .map((location) => Location.fromJson(location))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'arrivalDate': arrivalDate.toIso8601String(),
      'departureDate': departureDate.toIso8601String(),
      'locations': locations.map((location) => location.toJson()).toList(),
    };
  }
}
