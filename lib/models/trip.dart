import 'package:travel_planning_app/models/trip_creation_accomodation.dart';
import 'package:travel_planning_app/models/trip_creation_place.dart';
import 'package:travel_planning_app/models/trip_creation_travel.dart';

class Trip {
  String tripName;
  DateTime tripStartDate;
  DateTime tripEndDate;
  final List<Transport> transports;
  final List<TripCreationAccomodation> accomodations;
  final List<TripCreationPlace> places;

  Trip({
    required this.tripName,
    required this.tripStartDate,
    required this.tripEndDate,
    required this.transports,
    required this.accomodations,
    required this.places,
  });
}
