// To parse this JSON data, do
//
//     final changeMobileRequest = changeMobileRequestFromJson(jsonString);

import 'dart:convert';

ChangeMobileRequest changeMobileRequestFromJson(String str) => ChangeMobileRequest.fromJson(json.decode(str));

String changeMobileRequestToJson(ChangeMobileRequest data) => json.encode(data.toJson());

class ChangeMobileRequest {
  int userId;
  String mobileNumber;

  ChangeMobileRequest({
    required this.userId,
    required this.mobileNumber,
  });

  factory ChangeMobileRequest.fromJson(Map<String, dynamic> json) => ChangeMobileRequest(
    userId: json["user_id"],
    mobileNumber: json["mobile_number"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "mobile_number": mobileNumber,
  };
}
