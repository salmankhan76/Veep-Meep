import 'dart:convert';
class OfferingResponse{
  OfferingResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory OfferingResponse.fromJson(Map<String, dynamic> json) => OfferingResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}