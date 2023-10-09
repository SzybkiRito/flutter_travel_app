import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/models/city_images.dart';
import 'package:travel_planning_app/services/city_images_service.dart';

part 'city_images_event.dart';
part 'city_images_state.dart';

class CityImagesBloc extends Bloc<CityImagesEvent, CityImagesState> {
  List<String> cityImagesUrls = [];

  CityImagesBloc() : super(CityImagesInitial(cityName: '')) {
    on<InitialCityImagesEvent>(getCityImages);
  }

  FutureOr<void> getCityImages(CityImagesEvent event, Emitter<CityImagesState> emit) async {
    cityImagesUrls.clear();
    emit(CityImagesLoading());
    CityImagesPhoto cityImages = await CityImagesService(
      cityName: (event as InitialCityImagesEvent).cityName,
    ).getCityImages();

    if (cityImages.photoUrl.isEmpty) {
      emit(CityImagesEmpty());
    } else {
      cityImagesUrls.add(cityImages.photoUrl);
      emit(
        CityImagesLoaded(imageUrl: cityImages.photoUrl),
      );
    }
  }
}
