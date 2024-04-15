// To parse this JSON data, do
//
//     final signupRequest = signupRequestFromJson(jsonString);

import 'dart:convert';

SignupResponse signupRequestFromJson(String str) => SignupResponse.fromJson(json.decode(str));

class SignupResponse {
  bool success;
  String message;
  SignUpData? output;

  SignupResponse({
    required this.success,
    required this.message,
    required this.output,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
    success: json["success"],
    message: json["message"],
    output: json["output"]!=null?SignUpData.fromJson(json["output"]):null,
  );
}

class SignUpData {
  int userId;
  String token;
  int status;
  int accountType;

  SignUpData({
    required this.userId,
    required this.token,
    required this.status,
    required this.accountType
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
    userId: json["user_id"],
    token: json["token"]??'',
    status: json["status"],
    accountType: json["account_type"]??1,
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "token": token,
    "status": status,
    "account_type": accountType,
  };
}
