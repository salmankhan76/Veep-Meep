// To parse this JSON data, do
//
//     final matchDataRequest = matchDataRequestFromJson(jsonString);

import 'dart:convert';

MatchDataRequest? matchDataRequestFromJson(String str) => MatchDataRequest.fromJson(json.decode(str));

String matchDataRequestToJson(MatchDataRequest? data) => json.encode(data!.toJson());

class MatchDataRequest {
  MatchDataRequest({
   required this.userId,
  });

  int? userId;

  factory MatchDataRequest.fromJson(Map<String, dynamic> json) => MatchDataRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
