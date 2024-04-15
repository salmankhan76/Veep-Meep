// To parse this JSON data, do
//
//     final otpGenerateRequest = otpGenerateRequestFromJson(jsonString);

import 'dart:convert';

import '../../../../utils/enums.dart';

String otpGenerateRequestToJson(OtpGenerateRequest? data) => json.encode(data!.toJson());

class OtpGenerateRequest {
  OtpGenerateRequest({
    this.isGenerated,
    this.userId,
    this.emailAddress,
    required this.otpUseCase
  });

  int? isGenerated;
  int? userId;
  String? emailAddress;
  OTPUseCase otpUseCase;

  Map<String, dynamic> toJson() => {
    "is_generated": isGenerated,
    "user_id": userId,
    "email_address": emailAddress,
  };
}
