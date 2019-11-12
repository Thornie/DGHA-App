import 'package:dgha_brochure/models/review.dart';
import 'package:http/http.dart' as http;

// TODO: change the url to rootURL
class ReviewService {
  static Future<List<ReviewData>> getReviewSetById(String placeId, int setNum) async {
      http.Response res = await http.get('https://dgha-api-testing.azurewebsites.net/location/reviews?placeId=$placeId&set=$setNum', headers: {"Accept": "application/json"});

      if(res.statusCode == 200) {
        return ReviewData.decodeReviewListFromJson(res.body);
      } else {
        return List<ReviewData>(); 
      }
  }
}