// To parse this JSON data, do
//
//     final bizEditResponse = bizEditResponseFromJson(jsonString);

import 'dart:convert';

BizEditResponse bizEditResponseFromJson(String str) => BizEditResponse.fromJson(json.decode(str));

String bizEditResponseToJson(BizEditResponse data) => json.encode(data.toJson());

class BizEditResponse {
  bool success;
  String message;

  BizEditResponse({
    required this.success,
    required this.message,
  });

  factory BizEditResponse.fromJson(Map<String, dynamic> json) => BizEditResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
