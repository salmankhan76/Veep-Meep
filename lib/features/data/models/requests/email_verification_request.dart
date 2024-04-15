// To parse this JSON data, do
//
//     final emailVerificationRequest = emailVerificationRequestFromJson(jsonString);

import 'dart:convert';

EmailVerificationRequest? emailVerificationRequestFromJson(String str) => EmailVerificationRequest.fromJson(json.decode(str));

String emailVerificationRequestToJson(EmailVerificationRequest? data) => json.encode(data!.toJson());

class EmailVerificationRequest {
  EmailVerificationRequest({
    this.emailAddress,
    this.loginType,
  });

  String? emailAddress;
  int? loginType;

  factory EmailVerificationRequest.fromJson(Map<String, dynamic> json) => EmailVerificationRequest(
    emailAddress: json["email_address"],
    loginType: json["login_type"],
  );

  Map<String, dynamic> toJson() => {
    "email_address": emailAddress,
    "login_type": loginType,
  };
}
