import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/bloc/city_images/city_images_bloc.dart';
import 'package:travel_planning_app/bloc/trips/trips_bloc.dart';
import 'package:travel_planning_app/controllers/user_controller.dart';
import 'package:travel_planning_app/custom_widgets/cards/shimmer/trip_card_shimmer.dart';
import 'package:travel_planning_app/custom_widgets/cards/trip_card.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/pages/trip_preview_page/trip_preview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageimagesState();
}

class _HomePageimagesState extends State<HomePage> {
  void _requestTripsData() async {
    context.read<TripsBloc>().add(
          TripsInitial(
            email: await UserController.getCurrentUserId(),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _requestTripsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TripsBloc, TripsState>(
          builder: (context, tripState) {
            if (tripState is TripsLoadingState) {
              return const TripsWrapper(
                chilldren: [
                  TripCardShimmer(),
                  TripCardShimmer(),
                  TripCardShimmer(),
                ],
              );
            } else if (tripState is TripsEmptyState) {
              return const TripsWrapper(
                chilldren: [
                  Center(
                    child: Text('You have no trips planned yet'),
                  ),
                ],
              );
            } else if (tripState is TripsErrorState) {
              return const TripsWrapper(
                chilldren: [
                  Center(
                    child: Text('Something went wrong'),
                  ),
                ],
              );
            } else if (tripState is TripsLoadedState) {
              for (var trip in tripState.trips) {
                context.read<CityImagesBloc>().add(
                      InitialCityImagesEvent(cityName: trip.tripName),
                    );
              }

              return BlocBuilder<CityImagesBloc, CityImagesState>(
                builder: (context, imagesState) {
                  if (imagesState is CityImagesEmpty) {
                    return const TripsWrapper(
                      chilldren: [
                        Center(
                          child: Text('You have no trips planned yet'),
                        ),
                      ],
                    );
                  } else if (imagesState is CityImagesError) {
                    return const TripsWrapper(
                      chilldren: [
                        Center(
                          child: Text('Something went wrong'),
                        ),
                      ],
                    );
                  } else if (imagesState is CityImagesLoading) {
                    return const TripsWrapper(
                      chilldren: [
                        TripCardShimmer(),
                        TripCardShimmer(),
                        TripCardShimmer(),
                      ],
                    );
                  } else if (imagesState is CityImagesLoaded) {
                    final cityImagesBloc = context.read<CityImagesBloc>().cityImagesUrls;

                    if (cityImagesBloc.length == tripState.trips.length) {
                      return TripsWrapper(
                        chilldren: tripState.trips.asMap().entries.map((e) {
                          return TripCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripPreviewPage(
                                    trip: e.value,
                                    imageUrl: cityImagesBloc[e.key],
                                  ),
                                ),
                              );
                            },
                            cityName: e.value.tripName,
                            endDate: e.value.tripEndDate,
                            startDate: e.value.tripStartDate,
                            imageUrl: cityImagesBloc[e.key],
                          );
                        }).toList(),
                      );
                    } else {
                      return const TripsWrapper(
                        chilldren: [
                          TripCardShimmer(),
                          TripCardShimmer(),
                          TripCardShimmer(),
                        ],
                      );
                    }
                  } else {
                    return const TripsWrapper(
                      chilldren: [
                        Center(
                          child: Text('Something went wrong'),
                        ),
                      ],
                    );
                  }
                },
              );
            } else {
              return const TripsWrapper(
                chilldren: [
                  Center(
                    child: Text('Something went wrong'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class TripsWrapper extends StatelessWidget {
  const TripsWrapper({
    super.key,
    required this.chilldren,
  });
  final List<Widget> chilldren;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/nyc_header.png',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: TripCardsList(
            children: chilldren,
          ),
        ),
      ],
    );
  }
}

class TripCardsList extends StatelessWidget {
  const TripCardsList({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DefaultStylesConfig.kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming trips',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: children.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    if (children.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: children[index],
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
