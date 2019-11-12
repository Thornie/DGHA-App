class PlaceByQuery {
  final String name;
  final String placeId;
  final String address;
  final dynamic rating;
  final List<dynamic> types;

  PlaceByQuery({this.name, this.placeId, this.rating, this.types, this.address});

  factory PlaceByQuery.fromJson(Map<String, dynamic> json) {
    return PlaceByQuery(
      name: json['name'],
      placeId: json['place_id'],
      rating: json['rating'],
      types: json['types'],
      address: json['formatted_address'],
    );
  }
}

class PlaceData {
  String placeId;
  String name;
  String address;
  String state;
  List<String> types;
  double avgOverallRating;
  double avgCustomerRating;
  double avgAmentitiesRating;
  double avgLocationRating;
  int numOfRatings;

  PlaceData({this.placeId, this.name, this.address, this.state, this.types, this.avgOverallRating, this.avgCustomerRating, this.avgAmentitiesRating, this.avgLocationRating, this.numOfRatings});

  PlaceData.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    name = json['name'];
    address = json['address'];
    state = json['state'];
    types = json['types'].cast<String>();
    avgOverallRating = json['avgOverallRating'].toDouble();
    avgCustomerRating = json['avgCustomerRating'].toDouble();
    avgAmentitiesRating = json['avgAmentitiesRating'].toDouble();
    avgLocationRating = json['avgLocationRating'].toDouble();
    numOfRatings = json['numOfRatings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeId'] = this.placeId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['state'] = this.state;
    data['types'] = this.types;
    data['avgOverallRating'] = this.avgOverallRating;
    data['avgCustomerRating'] = this.avgCustomerRating;
    data['avgAmentitiesRating'] = this.avgAmentitiesRating;
    data['avgLocationRating'] = this.avgLocationRating;
    data['numOfRatings'] = this.numOfRatings;
    return data;
  }
}
