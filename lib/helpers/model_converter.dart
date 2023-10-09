import 'package:flutter/material.dart';

class ModelConverter {
  TimeOfDay convertStringHourToTimeOfDay(String hour) {
    List<String> hourList = hour.split(':');
    return TimeOfDay(
      hour: int.parse(hourList[0]),
      minute: int.parse(hourList[1]),
    );
  }

  String convertTimeOfDayToStringHour(TimeOfDay timeOfDay) {
    return "${timeOfDay.hour}:${timeOfDay.minute}";
  }
}
