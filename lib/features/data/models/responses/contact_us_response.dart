import 'dart:convert';
class ContactUsResponse{
  ContactUsResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) => ContactUsResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}