part of 'trip_bloc.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripInitial extends TripState {}

class TripLoaded extends TripState {
  final Trip? trip;

  const TripLoaded({required this.trip});

  @override
  List<Object?> get props => [trip];
}