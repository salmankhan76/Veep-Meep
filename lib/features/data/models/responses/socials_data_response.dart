// To parse this JSON data, do
//
//     final socialsDataSubmitResponse = socialsDataSubmitResponseFromJson(jsonString);

import 'dart:convert';

SocialsDataSubmitResponse socialsDataSubmitResponseFromJson(String str) => SocialsDataSubmitResponse.fromJson(json.decode(str));

String socialsDataSubmitResponseToJson(SocialsDataSubmitResponse data) => json.encode(data.toJson());

class SocialsDataSubmitResponse {
  SocialsDataSubmitResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory SocialsDataSubmitResponse.fromJson(Map<String, dynamic> json) => SocialsDataSubmitResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
