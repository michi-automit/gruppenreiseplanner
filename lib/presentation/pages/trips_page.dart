import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gruppenreise_planner/data/models/location_model.dart';
import 'package:intl/intl.dart';
import '../../data/models/trip_model.dart';
import '../blocs/trip_bloc.dart';
import '../widgets/create_trip_dialog.dart';
import '../widgets/location_list_tile.dart';

class TripsPage extends StatefulWidget {
  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  late List<Location> _locations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reisen'),
      ),
      body: BlocBuilder<TripBloc, TripState>(
        builder: (context, state) {
          print("Current state is: ${state.toString()}");
          if (state is TripLoaded) {
            if (state.trip != null) {
              print("Trip ${state.trip?.toJson()}");
              final trip = state.trip!;
              _locations = List.from(trip.locations);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ankunft: ${DateFormat.yMMMd().format(trip.arrivalDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Abreise: ${DateFormat.yMMMd().format(trip.departureDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TripBloc>().add(DeleteTrip());
                      },
                      child: Text('Reise löschen'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final item = _locations.removeAt(oldIndex);
                            _locations.insert(newIndex, item);
                          });
                        },
                        children: _locations
                            .map((location) => LocationListTile(
                                key: Key(location.name), location: location))
                            .toList(),
                      ),
                    ),
                  ],
                  
                ),
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateTripDialog(),
                    );
                  },
                  child: Text('Reise erstellen'),
                ),
              );
            }
          } else if (state is TripInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CreateTripDialog(),
                  );
                },
                child: Text('Reise erstellen'),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
