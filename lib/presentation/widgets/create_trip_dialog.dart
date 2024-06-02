import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/models/trip_model.dart';
import '../blocs/trip_bloc.dart';

class CreateTripDialog extends StatefulWidget {
  @override
  _CreateTripDialogState createState() => _CreateTripDialogState();
}

class _CreateTripDialogState extends State<CreateTripDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _arrivalDate;
  DateTime? _departureDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reise erstellen'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Reisename'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte einen Namen eingeben';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Ankunftsdatum'),
              readOnly: true,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (selectedDate != null) {
                  setState(() {
                    _arrivalDate = selectedDate;
                  });
                }
              },
              controller: TextEditingController(
                text: _arrivalDate != null
                    ? DateFormat.yMMMd().format(_arrivalDate!)
                    : '',
              ),
              validator: (value) {
                if (_arrivalDate == null) {
                  return 'Bitte ein Ankunftsdatum eingeben';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Abreisedatum'),
              readOnly: true,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (selectedDate != null) {
                  setState(() {
                    _departureDate = selectedDate;
                  });
                }
              },
              controller: TextEditingController(
                text: _departureDate != null
                    ? DateFormat.yMMMd().format(_departureDate!)
                    : '',
              ),
              validator: (value) {
                if (_departureDate == null) {
                  return 'Bitte ein Abreisedatum eingeben';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final trip = Trip(
                name: _nameController.text,
                arrivalDate: _arrivalDate!,
                departureDate: _departureDate!,
              );
              context.read<TripBloc>().add(CreateTrip(trip: trip));
              Navigator.of(context).pop();
            }
          },
          child: Text("Erstellen"),
        ),
      ],
    );
  }
}
