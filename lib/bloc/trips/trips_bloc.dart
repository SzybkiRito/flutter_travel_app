import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/controllers/user_controller.dart';
import 'package:travel_planning_app/models/trip.dart';
import 'package:travel_planning_app/models/trip_creation_accomodation.dart';
import 'package:travel_planning_app/models/trip_creation_place.dart';
import 'package:travel_planning_app/models/trip_creation_travel.dart';
import 'package:travel_planning_app/services/travels_table_service.dart';
part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  TripsBloc() : super(TripsInitialState()) {
    on<TripsInitial>(_loadTrips);
  }

  void _loadTrips(TripsInitial event, Emitter<TripsState> emit) async {
    emit(TripsLoadingState());
    try {
      final travels = await TravelsTableService().getAllTravelsOfUser(
        userEmail: await UserController.getCurrentUserId(),
      );
      List<Trip> trips = [];

      final travelsData = travels.map((e) => e['data']).toList();

      for (var i = 0; i < travelsData.length; i++) {
        final transportsList = json.decode(json.decode(travelsData[i])[0]['transports']);
        final accomodationsList = json.decode(json.decode(travelsData[i])[0]['accomodations']);
        final placesList = json.decode(json.decode(travelsData[i])[0]['places']);
        final tripStartDate = travels.map((e) => e['start_date']).toList();
        final tripEndDate = travels.map((e) => e['end_date']).toList();
        final tripName = travels.map((e) => e['destination']).toList();

        trips.add(
          Trip(
            tripName: tripName[i],
            tripStartDate: DateTime.parse(tripStartDate[i]),
            tripEndDate: DateTime.parse(tripEndDate[i]),
            transports: transportsList.map<Transport>((e) => Transport.fromJson(e)).toList(),
            accomodations:
                accomodationsList.map<TripCreationAccomodation>((e) => TripCreationAccomodation.fromJson(e)).toList(),
            places: placesList.map<TripCreationPlace>((e) => TripCreationPlace.fromJson(e)).toList(),
          ),
        );
      }

      if (trips.isEmpty) {
        emit(TripsEmptyState());
      } else {
        emit(
          TripsLoadedState(trips: trips),
        );
      }
    } catch (e) {
      emit(TripsErrorState(message: e.toString()));
    }
  }
}
