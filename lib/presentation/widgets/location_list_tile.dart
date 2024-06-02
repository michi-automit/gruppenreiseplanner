import 'package:flutter/material.dart';
import 'package:gruppenreise_planner/data/models/location_model.dart';

class LocationListTile extends StatelessWidget {
  final Location location;

  const LocationListTile({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(location.name),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(location.name),
        subtitle: Text(location.address),
        leading: CircleAvatar(
          backgroundImage: AssetImage(location.image),
        ),
        trailing: Icon(Icons.drag_handle),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: location,
          );
        },
      ),
    );
  }
}
