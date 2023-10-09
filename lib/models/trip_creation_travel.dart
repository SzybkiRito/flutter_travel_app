import 'package:flutter/material.dart';
import 'package:travel_planning_app/constants/transport_type.dart';
import 'package:travel_planning_app/helpers/model_converter.dart';

class Transport {
  Transport({
    required this.id,
    required this.date,
    required this.type,
    required this.departureTime,
    required this.arrivalTime,
    required this.filePath,
    required this.currentCity,
    required this.destinationCity,
  });

  final int id;
  final DateTime date;
  final TransportType type;
  final TimeOfDay departureTime;
  final TimeOfDay arrivalTime;
  final String filePath;
  final String currentCity;
  final String destinationCity;

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      type: TransportType.values.where((element) => element.name == json['type'] as String).first,
      departureTime: ModelConverter().convertStringHourToTimeOfDay(json['departureTime']),
      arrivalTime: ModelConverter().convertStringHourToTimeOfDay(json['arrivalTime']),
      filePath: json['filePath'] as String,
      currentCity: json['currentCity'] as String,
      destinationCity: json['destinationCity'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date.toIso8601String(),
        'type': type.name,
        'departureTime': "${departureTime.hour}:${departureTime.minute}",
        'arrivalTime': "${arrivalTime.hour}:${arrivalTime.minute}",
        'filePath': filePath,
        'currentCity': currentCity,
        'destinationCity': destinationCity,
      };
}
