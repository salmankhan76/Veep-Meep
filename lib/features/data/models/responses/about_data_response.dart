// To parse this JSON data, do
//
//     final aboutDataSubmitResponse = aboutDataSubmitResponseFromJson(jsonString);

import 'dart:convert';

AboutDataSubmitResponse aboutDataSubmitResponseFromJson(String str) => AboutDataSubmitResponse.fromJson(json.decode(str));

String aboutDataSubmitResponseToJson(AboutDataSubmitResponse data) => json.encode(data.toJson());

class AboutDataSubmitResponse {
  AboutDataSubmitResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory AboutDataSubmitResponse.fromJson(Map<String, dynamic> json) => AboutDataSubmitResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
