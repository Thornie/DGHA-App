import 'package:flutter/cupertino.dart';

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

// NOTE: by the end there will only be ONE (1) Place class and it's this one
class Place {
  final String placeId;
  final String name;
  final String address;
  final List<String> types;
  final double avgOverallRating;
  final double avgCustomerServiceRating;
  final double avgLocationRating;
  final double avgAmenitiesRating;
  final int numOfRatings;

  Place({
    this.placeId,
    this.name,
    this.address,
    this.types,
    this.avgOverallRating,
    this.avgCustomerServiceRating,
    this.avgLocationRating,
    this.avgAmenitiesRating,
    this.numOfRatings,
  });
}

class SearchAPIResponse {
  final String placeId;
  final String name;
  final String address;
  final List<dynamic> types;

  SearchAPIResponse({this.placeId, this.name, this.address, this.types});
}
