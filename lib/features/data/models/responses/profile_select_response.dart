import 'dart:convert';
class ProfileSelectResponse{
  ProfileSelectResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ProfileSelectResponse.fromJson(Map<String, dynamic> json) => ProfileSelectResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}