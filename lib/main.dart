import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/bloc/city_images/city_images_bloc.dart';
import 'package:travel_planning_app/bloc/trip_creation/trip_creation_cubit.dart';
import 'package:travel_planning_app/bloc/trips/trips_bloc.dart';
import 'package:travel_planning_app/firebase_options.dart';
import 'package:travel_planning_app/controllers/database_controller.dart';
import 'package:travel_planning_app/pages/starter_page/starter_page.dart';
import 'package:travel_planning_app/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DatabaseController().open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TripCreationCubit>(
          create: (context) => TripCreationCubit(),
        ),
        BlocProvider<CityImagesBloc>(
          create: (context) => CityImagesBloc(),
        ),
        BlocProvider<TripsBloc>(
          create: (context) => TripsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Travel Planning App',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const StarterPage(),
      ),
    );
  }
}
