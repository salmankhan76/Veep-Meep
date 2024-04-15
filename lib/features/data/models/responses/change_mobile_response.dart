import 'dart:convert';
class ChangeMobileResponse{
  ChangeMobileResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ChangeMobileResponse.fromJson(Map<String, dynamic> json) => ChangeMobileResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}