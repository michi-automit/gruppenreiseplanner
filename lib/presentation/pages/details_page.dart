import 'package:flutter/material.dart';
import '../../data/models/location_model.dart';
import '../../utils/icon_helper.dart';

class DetailsPage extends StatelessWidget {
  final Location location;

  const DetailsPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Image.asset(
                location.image,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Divider(),
              Text(
                'Adresse',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                location.address,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Divider(),
              Text(
                'Beschreibung',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                location.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Divider(),
              Text(
                'Öffnungszeiten',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: location.openingHours.map((hours) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(hours.day, style: TextStyle(fontSize: 16)),
                        Text('${hours.opening} - ${hours.closing}',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }).toList(),
              ),
              Divider(),
              Text(
                'Kategorien',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: location.categories.length,
                itemBuilder: (context, index) {
                  final category = location.categories[index];
                  return Row(
                    children: [
                      Icon(getIconData(category), size: 24),
                      SizedBox(width: 8),
                      Text(category),
                    ],
                  );
                },
              ),
              Divider(),
              Text(
                'Bilder',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Beispiel für die Anzahl der Bilder
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        color: Colors.grey[300],
                        child: Center(
                            child: Text(
                                'Bild ${index + 1}')), // Platzhalter für die Bilder
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
