// To parse this JSON data, do
//
//     final logoutRequest = logoutRequestFromJson(jsonString);

import 'dart:convert';

LogoutRequest logoutRequestFromJson(String str) => LogoutRequest.fromJson(json.decode(str));

String logoutRequestToJson(LogoutRequest data) => json.encode(data.toJson());

class LogoutRequest {
  String token;

  LogoutRequest({
    required this.token,
  });

  factory LogoutRequest.fromJson(Map<String, dynamic> json) => LogoutRequest(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
