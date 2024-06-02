import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/trip_bloc.dart';

class TripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        if (state is TripInitial) {
          return Center(child: Text('No trips yet'));
        }
        // Weitere Zustände behandeln
        return Container();
      },
    );
  }
}
