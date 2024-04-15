// To parse this JSON data, do
//
//     final userIdentifyRequest = userIdentifyRequestFromJson(jsonString);

import 'dart:convert';

UserIdentifyRequest userIdentifyRequestFromJson(String str) => UserIdentifyRequest.fromJson(json.decode(str));

String userIdentifyRequestToJson(UserIdentifyRequest data) => json.encode(data.toJson());

class UserIdentifyRequest {
  int userId;
  String emailAddress;

  UserIdentifyRequest({
    required this.userId,
    required this.emailAddress,
  });

  factory UserIdentifyRequest.fromJson(Map<String, dynamic> json) => UserIdentifyRequest(
    userId: json["user_id"],
    emailAddress: json["email_address"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email_address": emailAddress,
  };
}
