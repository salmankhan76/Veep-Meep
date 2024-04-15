// To parse this JSON data, do
//
//     final otpSubmitRequest = otpSubmitRequestFromJson(jsonString);

import 'dart:convert';

OtpSubmitRequest? otpSubmitRequestFromJson(String str) => OtpSubmitRequest.fromJson(json.decode(str));

String otpSubmitRequestToJson(OtpSubmitRequest? data) => json.encode(data!.toJson());

class OtpSubmitRequest {
  OtpSubmitRequest({
    required this.otpCode,
    this.userId,
    this.emailAddress,
  });

  String otpCode;
  int? userId;
  String? emailAddress;

  factory OtpSubmitRequest.fromJson(Map<String, dynamic> json) => OtpSubmitRequest(
    otpCode: json["otp"],
    userId: json["user_id"],
    emailAddress: json["email_address"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otpCode,
    "user_id": userId,
    "email_address": emailAddress,
  };
}
