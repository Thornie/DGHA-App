import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/models/search_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// TODO: change the url to rootURL
class PlaceService {
  static Future<String> getState() async {
    Position pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(pos.latitude, pos.longitude);
    String state = placemarks[0].administrativeArea;
    return state;
  }

  static Future<List<PlaceData>> getRecommendedPlaces() async {
    // NOTE: this only works with a physical device
    // final String state = await getState();
    final String state = "Victoria";

    String url = '${Data.rootTestingUrl}/location/recommend?state=$state';
    http.Response res = await http.get(url, headers: {"Accept": "application/json"});

    if(res.statusCode == 200) {
      return PlaceData.decodePlaceDataList(res.body);
    } else {
      return List<PlaceData>(); 
    }
  } 

  static Future<SearchPlace> getSearchedPlaces(String query, String nextPageToken) async {
    String formattedQuery = Helper().formatStringForQuery(query);
    String url = '${Data.rootTestingUrl}/location/search?query=$formattedQuery&nextpagetoken=$nextPageToken'; 
    http.Response res = await http.get(url, headers: {"Accept": "application/json"});

    if(res.statusCode == 200) {
      SearchPlace spr = SearchPlace.decodePlaceReponseFromJson(res.body);
      spr.nextPageToken = spr.nextPageToken != null ? spr.nextPageToken : '';

      return spr; 
    } else {
      return SearchPlace(places: List<PlaceData>(), nextPageToken: ''); 
    } 
  }
}