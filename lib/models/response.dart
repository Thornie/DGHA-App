import 'package:dgha/models/place.dart';

class ApiPlaceResult {
  dynamic result;
  PlaceData value;

  ApiPlaceResult({this.result, this.value});

  ApiPlaceResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    value = json['value'] != null ? new PlaceData.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    return data;
  }
}
