// To parse this JSON data, do
//
//     final emailVerificationResponse = emailVerificationResponseFromJson(jsonString);

import 'dart:convert';

EmailVerificationResponse emailVerificationResponseFromJson(String str) => EmailVerificationResponse.fromJson(json.decode(str));

String emailVerificationResponseToJson(EmailVerificationResponse data) => json.encode(data.toJson());

class EmailVerificationResponse {
  bool success;
  String message;
  VerificationData? output;

  EmailVerificationResponse({
    required this.success,
    required this.message,
    required this.output,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) => EmailVerificationResponse(
    success: json["success"],
    message: json["message"],
    output: VerificationData.fromJson(json["output"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "output": output!.toJson(),
  };
}

class VerificationData {
  int userId;
  String token;
  int accountType;

  VerificationData({
    required this.userId,
    required this.token,
    required this.accountType
  });

  factory VerificationData.fromJson(Map<String, dynamic> json) => VerificationData(
    userId: json["user_id"]??0,
    token: json["token"]??'',
    accountType: json["account_type"]??1,
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "token": token,
    "account_type": accountType,
  };
}
