import 'dart:convert';
class OtpSubmitResponse{
  OtpSubmitResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory OtpSubmitResponse.fromJson(Map<String, dynamic> json) => OtpSubmitResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}