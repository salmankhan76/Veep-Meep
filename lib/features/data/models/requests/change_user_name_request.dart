// To parse this JSON data, do
//
//     final changeUserNameRequest = changeUserNameRequestFromJson(jsonString);

import 'dart:convert';

ChangeUserNameRequest changeUserNameRequestFromJson(String str) => ChangeUserNameRequest.fromJson(json.decode(str));

String changeUserNameRequestToJson(ChangeUserNameRequest data) => json.encode(data.toJson());

class ChangeUserNameRequest {
  ChangeUserNameRequest({
    required this.userId,
    required this.userName,
  });

  int userId;
  String? userName;

  factory ChangeUserNameRequest.fromJson(Map<String, dynamic> json) => ChangeUserNameRequest(
    userId: json["user_id"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
  };
}
