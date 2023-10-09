import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/models/trip_creation_accomodation.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class AccomodationCard extends StatelessWidget {
  const AccomodationCard({super.key, required this.accomodation});
  final TripCreationAccomodation accomodation;

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
            Text(accomodation.name),
            Text(
              accomodation.address,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${DateFormat('d').format(accomodation.checkInDate)} - ${DateFormat('d MMMM y').format(accomodation.checkOutDate)}",
            ),
          ],
        ),
      ),
    );
  }
}
