part of 'trips_bloc.dart';

@immutable
sealed class TripsState {}

final class TripsInitialState extends TripsState {}

final class TripsLoadingState extends TripsState {}

final class TripsLoadedState extends TripsState {
  final List<Trip> trips;
  TripsLoadedState({required this.trips});
}

final class TripsErrorState extends TripsState {
  final String message;
  TripsErrorState({required this.message});
}

final class TripsEmptyState extends TripsState {}
