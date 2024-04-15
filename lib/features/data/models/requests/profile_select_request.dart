// To parse this JSON data, do
//
//     final profileSelectRequest = profileSelectRequestFromJson(jsonString);

import 'dart:convert';

ProfileSelectRequest profileSelectRequestFromJson(String str) => ProfileSelectRequest.fromJson(json.decode(str));

String profileSelectRequestToJson(ProfileSelectRequest data) => json.encode(data.toJson());

class ProfileSelectRequest {
  int userId;
  String profilePicture;

  ProfileSelectRequest({
    required this.userId,
    required this.profilePicture,
  });

  factory ProfileSelectRequest.fromJson(Map<String, dynamic> json) => ProfileSelectRequest(
    userId: json["user_id"],
    profilePicture: json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_picture": profilePicture,
  };
}
