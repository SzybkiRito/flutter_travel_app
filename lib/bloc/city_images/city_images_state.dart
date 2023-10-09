part of 'city_images_bloc.dart';

@immutable
sealed class CityImagesState {}

final class CityImagesInitial extends CityImagesState {
  final String cityName;
  CityImagesInitial({required this.cityName});
}

final class CityImagesLoading extends CityImagesState {}

final class CityImagesLoaded extends CityImagesState {
  final String imageUrl;
  CityImagesLoaded({required this.imageUrl});
}

final class CityImagesError extends CityImagesState {
  final String message;
  CityImagesError({required this.message});
}

final class CityImagesEmpty extends CityImagesState {}
