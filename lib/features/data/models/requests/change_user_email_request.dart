// To parse this JSON data, do
//
//     final changeUserEmailRequest = changeUserEmailRequestFromJson(jsonString);

import 'dart:convert';

ChangeUserEmailRequest changeUserEmailRequestFromJson(String str) =>
    ChangeUserEmailRequest.fromJson(json.decode(str));

String changeUserEmailRequestToJson(ChangeUserEmailRequest data) => json.encode(data.toJson());

class ChangeUserEmailRequest {
  ChangeUserEmailRequest({
    required this.userId,
    required this.userEmail,
  });

  int userId;
  String? userEmail;

  factory ChangeUserEmailRequest.fromJson(Map<String, dynamic> json) => ChangeUserEmailRequest(
    userId: json["user_id"],
    userEmail: json["email_address"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email_address": userEmail,
  };
}
