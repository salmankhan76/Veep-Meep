// To parse this JSON data, do
//
//     final userIdentifyResponse = userIdentifyResponseFromJson(jsonString);

import 'dart:convert';

UserIdentifyResponse userIdentifyResponseFromJson(String str) => UserIdentifyResponse.fromJson(json.decode(str));

String userIdentifyResponseToJson(UserIdentifyResponse data) => json.encode(data.toJson());

class UserIdentifyResponse {
  bool success;
  String message;
  Output output;

  UserIdentifyResponse({
    required this.success,
    required this.message,
    required this.output,
  });

  factory UserIdentifyResponse.fromJson(Map<String, dynamic> json) => UserIdentifyResponse(
    success: json["success"],
    message: json["message"],
    output: Output.fromJson(json["output"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "output": output.toJson(),
  };
}

class Output {
  int userId;
  int accountType;

  Output({
    required this.userId,
    required this.accountType,
  });

  factory Output.fromJson(Map<String, dynamic> json) => Output(
    userId: json["user_id"],
    accountType: json["account_type"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "account_type": accountType,
  };
}
