class ResponseData {
  final List<dynamic> htmlAttributions;
  final List<dynamic> results;
  final String status;

  ResponseData({this.htmlAttributions, this.results, this.status});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      htmlAttributions: json['html_attributions'],
      results: json['results'],
      status: json['status'],
    );
  }
}

class Place {
  final String name;
  final String placeId;
  final dynamic rating;
  final String address;
  final List<dynamic> types;

  Place({this.name, this.placeId, this.rating, this.types, this.address});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      placeId: json['place_id'],
      rating: json['rating'],
      types: json['types'],
      address: json['vicinity'],
    );
  }
}

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
