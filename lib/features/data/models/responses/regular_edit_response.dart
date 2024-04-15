// To parse this JSON data, do
//
//     final regularEditResponse = regularEditResponseFromJson(jsonString);

import 'dart:convert';

RegularEditResponse regularEditResponseFromJson(String str) => RegularEditResponse.fromJson(json.decode(str));

String regularEditResponseToJson(RegularEditResponse data) => json.encode(data.toJson());

class RegularEditResponse {
  bool success;
  String message;

  RegularEditResponse({
    required this.success,
    required this.message,
  });

  factory RegularEditResponse.fromJson(Map<String, dynamic> json) => RegularEditResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
