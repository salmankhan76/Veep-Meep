// To parse this JSON data, do
//
//     final veepDataResponse = veepDataResponseFromJson(jsonString);

import 'dart:convert';

VeepedUserResponse? veepedUserResponseFromJson(String str) =>
    VeepedUserResponse.fromJson(json.decode(str));

String veepedUserResponseToJson(VeepedUserResponse? data) =>
    json.encode(data!.toJson());

class VeepedUserResponse {
  VeepedUserResponse({
    required this.success,
    required this.message,
    this.output,
  });

  bool success;
  String message;
  List<VeepedUser>? output;

  factory VeepedUserResponse.fromJson(Map<String, dynamic> json) =>
      VeepedUserResponse(
        success: json["success"],
        message: json["message"],
        output: json["output"] == null
            ? []
            : List<VeepedUser>.from(
                json["output"]!.map((x) => VeepedUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "output": output == null
            ? []
            : List<dynamic>.from(output!.map((x) => x!.toJson())),
      };
}

class VeepedUser {
  VeepedUser({
    this.id,
    this.user_id,
    this.full_name,
    this.username,
    this.email,
    this.chat_id,
    this.order_by,
    this.last_message,
    this.avatar,
  });

  int? id;
  int? user_id;
  String? full_name;
  String? username;
  String? email;
  int? chat_id;
  String? order_by;
  dynamic last_message;
  String? avatar;

  factory VeepedUser.fromJson(Map<String, dynamic> json) => VeepedUser(
        id: json["id"],
        user_id: json["user_id"],
        full_name: json["full_name"],
        username: json["username"],
        email: json["email"],
        chat_id: json["chat_id"],
        order_by: json["order_by"],
        last_message: json["last_message"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "full_name": full_name,
        "username": username,
        "email": email,
        "chat_id": chat_id,
        "order_by": order_by,
        "last_message": last_message,
        "avatar": avatar,
      };
}
