import 'dart:convert';

import 'package:travel_planning_app/constants/api_keys.dart';
import 'package:travel_planning_app/services/api_service.dart';
import 'package:travel_planning_app/models/city_images.dart';

class CityImagesService {
  final String _cityName;
  CityImagesService({required String cityName}) : _cityName = cityName;

  Future<CityImagesPhoto> getCityImages() async {
    final response = await ApiService().get(ApiKeys.cityImagesApiUrl(_cityName));
    final jsonResponseBody = jsonDecode(response.body);
    CityImagesPhoto cityImages = CityImagesPhoto.fromJson(jsonResponseBody);

    return cityImages;
  }
}
