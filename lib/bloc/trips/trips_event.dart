part of 'trips_bloc.dart';

@immutable
sealed class TripsEvent {}

final class TripsInitial extends TripsEvent {
  final String? email;
  TripsInitial({required this.email});
}

final class TripsLoading extends TripsEvent {}

final class TripsLoaded extends TripsEvent {
  final List<dynamic> trips;
  TripsLoaded({required this.trips});
}

final class TripsError extends TripsEvent {
  final String message;
  TripsError({required this.message});
}
