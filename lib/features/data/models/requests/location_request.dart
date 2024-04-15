// To parse this JSON data, do
//
//     final locationRequest = locationRequestFromJson(jsonString);

import 'dart:convert';

LocationRequest locationRequestFromJson(String str) => LocationRequest.fromJson(json.decode(str));

String locationRequestToJson(LocationRequest data) => json.encode(data.toJson());

class LocationRequest {
  LocationRequest({
    required this.userId,
  });

  int userId;

  factory LocationRequest.fromJson(Map<String, dynamic> json) => LocationRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
