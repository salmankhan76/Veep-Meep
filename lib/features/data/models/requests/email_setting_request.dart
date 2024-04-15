// To parse this JSON data, do
//
//     final emailSettingRequest = emailSettingRequestFromJson(jsonString);

import 'dart:convert';

EmailSettingRequest emailSettingRequestFromJson(String str) => EmailSettingRequest.fromJson(json.decode(str));

String emailSettingRequestToJson(EmailSettingRequest data) => json.encode(data.toJson());

class EmailSettingRequest {
  EmailSettingRequest({
    required this.userId,
    required this.emailSettingId,
    required this.status,
  });

  int userId;
  int emailSettingId;
  int status;

  factory EmailSettingRequest.fromJson(Map<String, dynamic> json) => EmailSettingRequest(
    userId: json["user_id"],
    emailSettingId: json["email_setting_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email_setting_id": emailSettingId,
    "status": status,
  };
}
