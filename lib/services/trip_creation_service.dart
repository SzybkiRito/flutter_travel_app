import 'dart:convert';

import 'package:travel_planning_app/models/trip_creation_accomodation.dart';
import 'package:travel_planning_app/models/trip_creation_place.dart';
import 'package:travel_planning_app/models/trip_creation_travel.dart';

class TripCreationService {
  TripCreationService._privateConstructor();
  static final TripCreationService _instance = TripCreationService._privateConstructor();
  factory TripCreationService() {
    return _instance;
  }

  List<Transport> transports = [];
  List<TripCreationAccomodation> accomodations = [];
  List<TripCreationPlace> places = [];

  void addTransport(Transport transport) {
    transports.add(transport);
  }

  void removeTransport(Transport transport) {
    transports.remove(transport);
  }

  void clearTransports() {
    transports.clear();
  }

  List<Transport> getTransports() {
    return transports;
  }

  void addAccomodation(TripCreationAccomodation accomodation) {
    accomodations.add(accomodation);
  }

  void removeAccomodation(TripCreationAccomodation accomodation) {
    accomodations.remove(accomodation);
  }

  void clearAccomodations() {
    accomodations.clear();
  }

  List<TripCreationAccomodation> getAccomodations() {
    return accomodations;
  }

  void addPlace(TripCreationPlace place) {
    places.add(place);
  }

  void removePlace(TripCreationPlace place) {
    places.remove(place);
  }

  void clearPlaces() {
    places.clear();
  }

  List<TripCreationPlace> getPlaces() {
    return places;
  }

  void clearAll() {
    clearTransports();
    clearAccomodations();
    clearPlaces();
  }

  String toJson() {
    List<Map<String, dynamic>> jsonMap = [
      {
        'transports': json.encode(transports.map((e) => e.toJson()).toList()),
        'accomodations': json.encode(accomodations.map((e) => e.toJson()).toList()),
        'places': json.encode(places.map((e) => e.toJson()).toList()),
      }
    ];

    return json.encode(jsonMap);
  }
}
