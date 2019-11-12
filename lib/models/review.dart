import 'dart:convert';

class ReviewData {
  final String placeId;
  final String userId;
  final String timeAdded;
  final String comment;
  final int overallRating;
  final int locationRating;
  final int custServRating;
  final int amenitiesRating;

    ReviewData({
    this.placeId = "",
    this.userId = "",
    this.timeAdded = "",
    this.comment = "",
    this.overallRating = 0,
    this.locationRating = 0,
    this.custServRating = 0,
    this.amenitiesRating = 0,
    });

    factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        userId: json["userID"],
        placeId: json["placeID"],
        timeAdded: json["timeAdded"],
        overallRating: json["overallRating"],
        locationRating: json["locationRating"],
        amenitiesRating: json["amentitiesRating"],
        custServRating: json["serviceRating"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "userID": userId,
        "placeID": placeId,
        "overallRating": overallRating,
        "locationRating": locationRating,
        "amentitiesRating": amenitiesRating,
        "serviceRating": custServRating,
        "comment": comment,
    };

    DateTime formatDateAdded() {
      if(this.timeAdded.length > 23) {

        String formatDateAdded = this.timeAdded.substring(0, 22);
        return DateTime.parse(formatDateAdded);
      }

      return DateTime.now(); 
    }

    static List<ReviewData> decodeReviewListFromJson(String data) {
      return List<ReviewData>.from(json.decode(data).map((x) => ReviewData.fromJson(x)));
    }

    static String encodeReviewListToJson(List<ReviewData> data) {
      return json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
    }
}

