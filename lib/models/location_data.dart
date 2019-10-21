class LocationData {
  final String name;
  final String address;
  final double overallRating;
  final double customerServiceRating;
  final double amenitiesRating;
  final double locationRating;
  final String placeId;
  final double latitude;
  final double longitude;

  LocationData({
    this.name,
    this.address,
    this.overallRating,
    this.customerServiceRating,
    this.amenitiesRating,
    this.locationRating,
    this.placeId = "",
    this.latitude = 0,
    this.longitude = 0,
  });
}
