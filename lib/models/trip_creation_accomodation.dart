import 'package:flutter/material.dart';
import 'package:travel_planning_app/helpers/model_converter.dart';

class TripCreationAccomodation {
  String name;
  String address;
  TimeOfDay checkInTime;
  TimeOfDay checkOutTime;
  DateTime checkInDate;
  DateTime checkOutDate;

  TripCreationAccomodation({
    required this.name,
    required this.address,
    required this.checkInTime,
    required this.checkOutTime,
    required this.checkInDate,
    required this.checkOutDate,
  });

  TimeOfDay convertStringHourToTimeOfDay(String hour) {
    List<String> hourList = hour.split(':');
    return TimeOfDay(
      hour: int.parse(hourList[0]),
      minute: int.parse(hourList[1]),
    );
  }

  factory TripCreationAccomodation.fromJson(Map<String, dynamic> json) {
    return TripCreationAccomodation(
      name: json['name'],
      address: json['address'],
      checkInTime: ModelConverter().convertStringHourToTimeOfDay(json['checkInTime']),
      checkOutTime: ModelConverter().convertStringHourToTimeOfDay(json['checkInTime']),
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'checkInTime': "${checkInTime.hour}:${checkInTime.minute}",
      'checkOutTime': "${checkOutTime.hour}:${checkOutTime.minute}",
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
    };
  }
}
