import 'dart:convert';
import 'package:dgha_brochure/models/account.dart';
import 'package:dgha_brochure/models/review_place.dart';
import 'package:dgha_brochure/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;

// Class to handle all calls to the DGHA API
class DghaApi {
  static final String rootUrl = "https://dgha-api.azurewebsites.net";
  static oauth2.Client currentClient;

//------------------------------ Note: Get UserID from token ------------------------------//
  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  //------------------------------ Note: Authentication ------------------------------//
  static Future<oauth2.Client> signIn(String username, String password) async {
    // Authentication parameters
    Uri tokenEndpoint = Uri.parse(
        "https://dgha-identityserver.azurewebsites.net/connect/token");
    String identifier = "ro.client";
    String secret = "secret";

    // Request client from token endpoint
    oauth2.Client client = await oauth2.resourceOwnerPasswordGrant(
      tokenEndpoint,
      username,
      password,
      identifier: identifier,
      secret: secret,
    );

    currentClient = client;
    return client;
  }

  static void signOut() {
    currentClient = null;
  }

  //------------------------------ Note: Accounts ------------------------------//
  static Future<http.Response> postAccount(
    String email,
    String password,
  ) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    http.Response response = await http.post(
      "$rootUrl/Accounts",
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );

    return response;
  }

  static Future<Account> getAccount() async {
    if (currentClient != null) {
      http.Response response = await currentClient.get(
        "$rootUrl/Accounts/${parseJwt(currentClient.credentials.accessToken)['sub']}",
        headers: {
          "content-type": "application/json",
        },
      );

      //Prevent decoding errors with a blank body
      if (response.body == "") {
        return Account();
      }

      var json = jsonDecode(response.body);
      Account account = new Account(id: json['id'], email: json['email']);

      return account;
    } else {
      print("User not logged in");
      return null;
    }
  }

  static Future<http.Response> deleteAccount() async {
    if (currentClient != null) {
      http.Response response = await currentClient.delete(
        "$rootUrl/Accounts/${parseJwt(currentClient.credentials.accessToken)['sub']}",
        headers: {
          "content-type": "application/json",
        },
      );

      return response;
    } else {
      print("User not logged in");
      return null;
    }
  }

  static Future<http.Response> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    if (currentClient != null) {
      http.Response response = await currentClient.put(
        "$rootUrl/Accounts/${parseJwt(currentClient.credentials.accessToken)['sub']}/UpdatePassword?currentPassword=$currentPassword&newPassword=$newPassword",
        headers: {
          "content-type": "application/json",
        },
      );

      return response;
    } else {
      print("User not logged in");
      return null;
    }
  }

  //------------------------------ Note: Complaints ------------------------------//
  static Future<http.Response> postComplaint(
    String placeID,
    String comment,
  ) async {
    if (currentClient != null) {
      Map<String, dynamic> data = {
        "userID": parseJwt(currentClient.credentials.accessToken)['sub'],
        "placeID": placeID,
        "comment": comment,
      };

      http.Response response = await currentClient.post(
        "$rootUrl/Complaints",
        body: jsonEncode(data),
        headers: {"content-type": "application/json"},
      );

      return response;
    } else {
      print("User not logged in");
      return null;
    }
  }
  //------------------------------ Note: Locations ------------------------------//

  //------------------------------ Note: Reviews ------------------------------//
  static Future<http.Response> postReview(
    String placeId,
    int overallRating,
    int locationRating,
    int amenitiesRating,
    int serviceRating,
    String comment,
  ) async {
    if (currentClient != null) {
      Map<String, dynamic> data = {
        "userID": parseJwt(currentClient.credentials.accessToken)['sub'],
        "placeID": placeId,
        "overallRating": overallRating,
        "locationRating": locationRating,
        "amentitiesRating": amenitiesRating,
        "serviceRating": serviceRating,
        "comment": comment,
      };

      http.Response response = await currentClient.post(
        "$rootUrl/Reviews",
        body: jsonEncode(data),
        headers: {"content-type": "application/json"},
      );

      return response;
    } else {
      print("User not logged in");
      return null;
    }
  }

  static Future<ReviewPlace> getReviewsFromPlaceId(String placeId) async {
    http.Response response = await http.get(
      "$rootUrl/Reviews/placeId/$placeId",
      headers: {
        "content-type": "application/json",
      },
    );

    //Prevent decoding errors with a blank body
    if (response.body == "" || response.statusCode != 200) {
      print(response.statusCode);
      return ReviewPlace(reviews: new List<Review>());
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    //Get all individual reviews
    List<Review> userReviews = new List<Review>();
    for (int i = 0; i < json['reviews'].length; i++) {
      Review r = new Review(
        placeId: json['reviews'][i]['placeId'],
        userId: json['reviews'][i]['userId'],
        timeAdded: json['reviews'][i]['timeAdded'],
        comment: json['reviews'][i]['comment'],
        overallRating: json['reviews'][i]['overallRating'],
        locationRating: json['reviews'][i]['locationRating'],
        custServRating: json['reviews'][i]['serviceRating'],
        amenitiesRating: json['reviews'][i]['amenitiesRating'],
      );

      userReviews.add(r);
    }

    ReviewPlace reviews = new ReviewPlace(
      averageRating: json['averageRating'].toDouble(),
      averageLocationRating: json['averageLocationRating'].toDouble(),
      averageAmenitiesRating: json['averageAmentitiesRating'].toDouble(),
      averageServiceRating: json['averageServiceRating'].toDouble(),
      count: json['count'],
      reviews: userReviews,
    );

    return reviews;
  }

  static Future<List<Review>> getReviewsFromPlaceIdAndSet(
    String placeId,
    int setIndex,
  ) async {
    http.Response response = await http.get(
      "$rootUrl/Reviews/placeId/$placeId/$setIndex",
      headers: {
        "content-type": "application/json",
      },
    );

    //Prevent decoding errors with a blank body
    if (response.body == "" || response.statusCode != 200) {
      print(response.statusCode);
      return List<Review>();
    }

    List<dynamic> json = jsonDecode(response.body);

    //Get all reviews
    List<Review> userReviews = new List<Review>();
    for (int i = 0; i < json.length; i++) {
      Review r = new Review(
        placeId: json[i]['placeId'],
        userId: json[i]['userId'],
        timeAdded: json[i]['timeAdded'],
        comment: json[i]['comment'],
        overallRating: json[i]['overallRating'],
        locationRating: json[i]['locationRating'],
        custServRating: json[i]['serviceRating'],
        amenitiesRating: json[i]['amenitiesRating'],
      );

      userReviews.add(r);
    }

    return userReviews;
  }

  static Future<List<Review>> getReviewsFromUser() async {
    http.Response response = await http.get(
      "$rootUrl/Reviews/userId/${parseJwt(currentClient.credentials.accessToken)['sub']}",
      headers: {
        "content-type": "application/json",
      },
    );

    //Prevent decoding errors with a blank body
    if (response.body == "") {
      return new List<Review>();
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    List<Review> userReviews = new List<Review>();
    for (int i = 0; i < json.length; i++) {
      Review r = new Review(
        placeId: json[i]['placeId'],
        userId: json[i]['userId'],
        timeAdded: json[i]['timeAdded'],
        comment: json[i]['comment'],
        overallRating: json[i]['overallRating'],
        locationRating: json[i]['locationRating'],
        custServRating: json[i]['serviceRating'],
        amenitiesRating: json[i]['amenitiesRating'],
      );

      userReviews.add(r);
    }

    return userReviews;
  }

  static Future<Review> getReviewFromPlaceIdAndUserId(
    String placeId,
    String userId,
  ) async {
    http.Response response = await http.get(
      "$rootUrl/Reviews/$placeId/$userId",
      headers: {
        "content-type": "application/json",
      },
    );

    //Prevent decoding errors with a blank body
    if (response.body == "") {
      return Review();
    }

    Map<String, dynamic> json = jsonDecode(response.body);
    Review review = new Review(
      placeId: json['placeId'],
      userId: json['userId'],
      timeAdded: json['timeAdded'],
      comment: json['comment'],
      overallRating: json['overallRating'],
      locationRating: json['locationRating'],
      custServRating: json['serviceRating'],
      amenitiesRating: json['amenitiesRating'],
    );

    return review;
  }

  static Future<http.Response> updateReview(
    String placeId,
    int overallRating,
    int locationRating,
    int amenitiesRating,
    int servicceRating,
    String comment,
  ) async {
    if (currentClient != null) {
      Map<String, dynamic> data = {
        "userID": parseJwt(currentClient.credentials.accessToken)['sub'],
        "placeID": placeId,
        "overallRating": overallRating,
        "locationRating": locationRating,
        "amentitiesRating": amenitiesRating,
        "serviceRating": servicceRating,
        "comment": comment,
      };

      http.Response response = await currentClient.put(
        "$rootUrl/Reviews/$placeId/${parseJwt(currentClient.credentials.accessToken)['sub']}",
        body: jsonEncode(data),
        headers: {"content-type": "application/json"},
      );

      return response;
    } else {
      print("User not logged in");
      return null;
    }
  }

  static Future<http.Response> deleteReview(String placeId) async {
    if (currentClient != null) {
      http.Response response = await currentClient.delete(
        "$rootUrl/Reviews/$placeId/${parseJwt(currentClient.credentials.accessToken)['sub']}",
        headers: {
          "content-type": "application/json",
        },
      );

      return response;
    } else {
      print("User not logged in");
      return null;
    }
  }
}
