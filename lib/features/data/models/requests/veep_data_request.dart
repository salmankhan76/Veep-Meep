// To parse this JSON data, do
//
//     final veepDataRequest = veepDataRequestFromJson(jsonString);

import 'dart:convert';

VeepDataRequest? veepDataRequestFromJson(String str) => VeepDataRequest.fromJson(json.decode(str));

String veepDataRequestToJson(VeepDataRequest? data) => json.encode(data!.toJson());

class VeepDataRequest {
  VeepDataRequest({
    required this.userId,
  });

  int? userId;

  factory VeepDataRequest.fromJson(Map<String, dynamic> json) => VeepDataRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
