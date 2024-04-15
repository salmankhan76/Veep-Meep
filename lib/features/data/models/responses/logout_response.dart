import 'dart:convert';
class LogoutResponse{
  LogoutResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}