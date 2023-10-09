import 'package:flutter/material.dart';
import 'package:travel_planning_app/helpers/model_converter.dart';

class TripCreationPlace {
  String name;
  String address;
  DateTime date;
  TimeOfDay checkInTime;
  TimeOfDay checkOutTime;

  TripCreationPlace({
    required this.name,
    required this.address,
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory TripCreationPlace.fromJson(Map<String, dynamic> json) {
    return TripCreationPlace(
      name: json['name'],
      address: json['address'],
      date: DateTime.parse(json['date']),
      checkInTime: ModelConverter().convertStringHourToTimeOfDay(json['checkInTime']),
      checkOutTime: ModelConverter().convertStringHourToTimeOfDay(json['checkOutTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'date': date.toIso8601String(),
      'checkInTime': "${checkInTime.hour}:${checkInTime.minute}",
      'checkOutTime': "${checkOutTime.hour}:${checkOutTime.minute}",
    };
  }
}
