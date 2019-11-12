import 'dart:convert';
import 'package:dgha_brochure/models/place.dart';

class SearchPlace {
  List<PlaceData> places = new List<PlaceData>();
  String nextPageToken = '';

  SearchPlace({
    this.places,
    this.nextPageToken,
  });

  factory SearchPlace.fromJson(Map<String, dynamic> json) => SearchPlace(
        places: List<PlaceData>.from(json["results"].map((x) => PlaceData.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(places.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };

  static SearchPlace decodePlaceReponseFromJson(String data) {
    return SearchPlace.fromJson(json.decode(data));
  }

  static String encodePlaceResponseToJson(SearchPlace data) {
    return json.encode(data.toJson());
  }
}
