// To parse this JSON data, do
//
//     final emailSettingResponse = emailSettingResponseFromJson(jsonString);

import 'dart:convert';

EmailSettingResponse emailSettingResponseFromJson(String str) => EmailSettingResponse.fromJson(json.decode(str));

String emailSettingResponseToJson(EmailSettingResponse data) => json.encode(data.toJson());

class EmailSettingResponse {
  EmailSettingResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory EmailSettingResponse.fromJson(Map<String, dynamic> json) => EmailSettingResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
