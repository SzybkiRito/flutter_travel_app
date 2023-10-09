class ApiKeys {
  static String cityImagesApiUrl(String cityName) {
    if (cityName.contains(' ')) {
      cityName = cityName.replaceAll(' ', '-');
    }

    return "https://api.teleport.org/api/urban_areas/slug:${cityName.toLowerCase()}/images/";
  }
}
