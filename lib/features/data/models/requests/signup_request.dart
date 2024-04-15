// To parse this JSON data, do
//
//     final signupRequest = signupRequestFromJson(jsonString);

import 'dart:convert';

SignupRequest signupRequestFromJson(String str) => SignupRequest.fromJson(json.decode(str));

String signupRequestToJson(SignupRequest data) => json.encode(data.toJson());

class SignupRequest {
  String emailAddress;
  int packageId;
  int accountType;

  SignupRequest({
    required this.emailAddress,
    required this.packageId,
    required this.accountType,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    emailAddress: json["email_address"],
    packageId: json["package_id"],
    accountType: json["account_type"],
  );

  Map<String, dynamic> toJson() => {
    "email_address": emailAddress,
    "package_id": packageId,
    "account_type": accountType,
  };
}
