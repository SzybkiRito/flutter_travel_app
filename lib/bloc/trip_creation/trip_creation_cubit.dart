import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_planning_app/services/travels_table_service.dart';

part 'trip_creation_state.dart';

class TripCreationCubit extends Cubit<TripCreationState> {
  TripCreationCubit() : super(TripCreationInitial());
  DateTime? startDate;
  DateTime? endDate;

  void setTripDates({required DateTime startDate, required DateTime endDate}) {
    this.startDate = startDate;
    this.endDate = endDate;

    emit(
      TripCreationDates(
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  Future<bool> saveNewTrip({
    required String tripName,
    required String tripData,
  }) async {
    final dates = state as TripCreationDates;

    return await TravelsTableService().saveNewTravel(
          desitination: tripName,
          startDate: dates.startDate,
          endDate: dates.endDate,
          tripData: tripData,
        ) >
        0;
  }
}
