part of 'trip_creation_cubit.dart';

@immutable
sealed class TripCreationState {}

class TripCreationInitial extends TripCreationState {}

class TripCreationDates extends TripCreationState {
  TripCreationDates({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;
}

class TripCreationStart extends TripCreationState {
  TripCreationStart({
    required this.tripName,
    required this.dates,
  });

  final String tripName;
  final TripCreationDates dates;
}
