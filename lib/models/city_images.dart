class CityImagesPhoto {
  String photoUrl;

  CityImagesPhoto({required this.photoUrl});

  factory CityImagesPhoto.fromJson(Map<String, dynamic> json) {
    return CityImagesPhoto(photoUrl: json['photos'][0]['image']['web']);
  }
}
