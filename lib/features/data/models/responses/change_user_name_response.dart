import 'dart:convert';
class ChangeUsernameResponse{
  ChangeUsernameResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ChangeUsernameResponse.fromJson(Map<String, dynamic> json) => ChangeUsernameResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}