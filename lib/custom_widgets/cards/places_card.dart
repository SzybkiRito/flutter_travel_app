import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/models/trip_creation_place.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class PlacesCard extends StatelessWidget {
  const PlacesCard({super.key, required this.place});
  final TripCreationPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kDefaultLightBlueColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(place.name),
            Text(
              place.address,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "${DateFormat('d MMMM y').format(place.date)} ${place.checkInTime.hour}:${place.checkInTime.minute} - ${place.checkOutTime.hour}:${place.checkOutTime.minute}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
