part of 'city_images_bloc.dart';

@immutable
sealed class CityImagesEvent {}

class InitialCityImagesEvent extends CityImagesEvent {
  final String cityName;
  InitialCityImagesEvent({required this.cityName});
}

class CityImagesErrorEvent extends CityImagesEvent {
  final String message;
  CityImagesErrorEvent({required this.message});
}

class CityImagesLoadedEvent extends CityImagesEvent {
  final String imageUrl;
  CityImagesLoadedEvent({required this.imageUrl});
}
