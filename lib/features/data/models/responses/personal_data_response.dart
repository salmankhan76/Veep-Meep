import 'dart:convert';
class PersonalDataResponse{
  PersonalDataResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory PersonalDataResponse.fromJson(Map<String, dynamic> json) => PersonalDataResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}