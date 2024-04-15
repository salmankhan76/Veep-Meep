// To parse this JSON data, do
//
//     final locationRequest = locationRequestFromJson(jsonString);

import 'dart:convert';

LocationResponse locationRequestFromJson(String str) => LocationResponse.fromJson(json.decode(str));

String locationRequestToJson(LocationResponse data) => json.encode(data.toJson());

class LocationResponse {
  LocationResponse({
    required this.success,
    required this.message,
    this.output,
  });

  bool success;
  String message;
  List<LocationData>? output;

  factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
    success: json["success"],
    message: json["message"],
    output: List<LocationData>.from(json["output"].map((x) => LocationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "output": List<dynamic>.from(output!.map((x) => x.toJson())),
  };
}

class LocationData {
  LocationData({
    required this.userId,
    required this.state,
    required this.town,
  });

  int userId;
  String state;
  String town;

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    userId: json["user_id"],
    state: json["state"],
    town: json["town"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "state": state,
    "town": town,
  };
}
