import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/custom_widgets/cards/accomodation_card.dart';
import 'package:travel_planning_app/custom_widgets/cards/flight_card.dart';
import 'package:travel_planning_app/custom_widgets/cards/places_card.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/models/trip.dart';

class TripPreviewPage extends StatefulWidget {
  const TripPreviewPage({
    super.key,
    required this.trip,
    required this.imageUrl,
  });
  final Trip trip;
  final String imageUrl;

  @override
  State<TripPreviewPage> createState() => _TripPreviewPageState();
}

class _TripPreviewPageState extends State<TripPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(DefaultStylesConfig.kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.trip.tripName,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                          "${DateFormat('d MMM y').format(widget.trip.tripEndDate)} - ${DateFormat('d MMM y').format(widget.trip.tripEndDate)}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Flight ',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.trip.transports.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: FlightCard(
                              transport: widget.trip.transports[0],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Accomodation ',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.trip.accomodations.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: AccomodationCard(
                              accomodation: widget.trip.accomodations[index],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Activities ',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.trip.places.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: PlacesCard(
                              place: widget.trip.places[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
