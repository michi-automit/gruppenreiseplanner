part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List get props => [];
}

class LoadTrip extends TripEvent {}

class CreateTrip extends TripEvent {
  final Trip trip;

  const CreateTrip({required this.trip});

  @override
  List get props => [trip];
}

class DeleteTrip extends TripEvent {}

class AddLocationToTrip extends TripEvent {
  final Location location;

  const AddLocationToTrip({required this.location});

  @override
  List get props => [location];
}

class RemoveLocationFromTrip extends TripEvent {
  final Location location;

  const RemoveLocationFromTrip({required this.location});

  @override
  List get props => [location];
}

class UpdateLocationOrder extends TripEvent {
  final List<Location> updatedLocations;

  const UpdateLocationOrder({required this.updatedLocations});

  @override
  List<Object> get props => [updatedLocations];
}
