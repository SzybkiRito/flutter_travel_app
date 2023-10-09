import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:travel_planning_app/models/trip_creation_travel.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class FlightCard extends StatelessWidget {
  const FlightCard({super.key, required this.transport});
  final Transport transport;

  double getFlightDuration(TimeOfDay departureTime, TimeOfDay arrivalTime) {
    int arrivalTimeInMinutes = arrivalTime.hour * 60 + arrivalTime.minute;
    int departureTimeInMinutes = departureTime.hour * 60 + departureTime.minute;

    return (departureTimeInMinutes - arrivalTimeInMinutes) / 60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kDefaultLightBlueColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(transport.currentCity),
                    Text(
                      '${transport.departureTime.hour}:${transport.departureTime.minute}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 18.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(transport.destinationCity),
                    Text(
                      '${transport.arrivalTime.hour}:${transport.arrivalTime.minute}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Flight duration: ${getFlightDuration(transport.arrivalTime, transport.departureTime)} h",
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                  size: 18.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('d MMMM y').format(transport.date),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ticket: '),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    OpenFilex.open(transport.filePath);
                  },
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
