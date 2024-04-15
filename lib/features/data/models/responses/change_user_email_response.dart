import 'dart:convert';
class ChangeUserEmailResponse{
  ChangeUserEmailResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ChangeUserEmailResponse.fromJson(Map<String, dynamic> json) => ChangeUserEmailResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}