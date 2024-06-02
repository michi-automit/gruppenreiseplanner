import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/trip_model.dart';
import '../../data/models/location_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends HydratedBloc<TripEvent, TripState> {
  TripBloc() : super(TripInitial()) {
    on<LoadTrip>(_onLoadTrip);
    on<CreateTrip>(_onCreateTrip);
    on<DeleteTrip>(_onDeleteTrip);
    on<AddLocationToTrip>(_onAddLocationToTrip);
    on<RemoveLocationFromTrip>(_onRemoveLocationFromTrip);
    on<UpdateLocationOrder>(_onUpdateLocationOrder);
  }

  void _onLoadTrip(LoadTrip event, Emitter<TripState> emit) {
    if (state is TripLoaded) {
      emit(state);  // Behalte den aktuellen Zustand bei
    } else {
      emit(TripInitial());
    }
  }

  void _onCreateTrip(CreateTrip event, Emitter<TripState> emit) {
    emit(TripLoaded(trip: event.trip));
  }

  void _onDeleteTrip(DeleteTrip event, Emitter<TripState> emit) {
    emit(TripLoaded(trip: null));
  }

  void _onAddLocationToTrip(AddLocationToTrip event, Emitter<TripState> emit) {
    if (state is TripLoaded) {
      final currentState = state as TripLoaded;
      final updatedTrip = currentState.trip!.copyWith(
        locations: List.from(currentState.trip!.locations)..add(event.location),
      );
      emit(TripLoaded(trip: updatedTrip));
    }
  }

  void _onRemoveLocationFromTrip(RemoveLocationFromTrip event, Emitter<TripState> emit) {
    if (state is TripLoaded) {
      final currentState = state as TripLoaded;
      final updatedTrip = currentState.trip!.copyWith(
        locations: List.from(currentState.trip!.locations)..remove(event.location),
      );
      emit(TripLoaded(trip: updatedTrip));
    }
  }

  void _onUpdateLocationOrder(UpdateLocationOrder event, Emitter<TripState> emit) {
    if (state is TripLoaded) {
      final currentState = state as TripLoaded;
      final updatedTrip = currentState.trip!.copyWith(
        locations: event.updatedLocations,
      );
      emit(TripLoaded(trip: updatedTrip));
    }
  }

  @override
  TripState fromJson(Map<String, dynamic> json) {
    try {
      final trip = Trip.fromJson(json['trip']);
      return TripLoaded(trip: trip);
    } catch (_) {
      return TripInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(TripState state) {
    if (state is TripLoaded && state.trip != null) {
      return {'trip': state.trip!.toJson()};
    }
    return {};
  }
}