import 'dart:convert';
import 'package:dgha_brochure/models/place.dart';

class SearchPlaceResponse {
  List<PlaceData> results;
  String nextPageToken;

  SearchPlaceResponse({
    this.results,
    this.nextPageToken,
  });

  factory SearchPlaceResponse.fromJson(Map<String, dynamic> json) => SearchPlaceResponse(
        results: List<PlaceData>.from(json["results"].map((x) => PlaceData.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };

  static SearchPlaceResponse decodePlaceReponseFromJson(String data) {
    return SearchPlaceResponse.fromJson(json.decode(data));
  }

  static String encodePlaceResponseToJson(SearchPlaceResponse data) {
    return json.encode(data.toJson());
  }
}
