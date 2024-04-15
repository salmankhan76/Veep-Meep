import 'dart:convert';

GetMessagesResponse? getMessagesResponseFromJson(String str) =>
    GetMessagesResponse.fromJson(json.decode(str));

String getMessagesResponseToJson(GetMessagesResponse? data) =>
    json.encode(data!.toJson());

class GetMessagesResponse {
  GetMessagesResponse({
    required this.success,
    required this.message,
    this.output,
  });

  bool success;
  String message;
  List<chatMessage>? output;

  factory GetMessagesResponse.fromJson(Map<String, dynamic> json) =>
      GetMessagesResponse(
        success: json["success"],
        message: json["message"],
        output: json["output"] == null
            ? []
            : List<chatMessage>.from(
                json["output"]["data"]!.map((x) => chatMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "output": output == null
            ? []
            : List<dynamic>.from(output!.map((x) => x!.toJson())),
      };
}

class chatMessage {
  chatMessage(
      {this.id,
      this.chat_id,
      this.sender_id,
      this.receiver_id,
      this.sender_name,
      this.content,
      this.created_at,
      this.read_at,
      this.media});

  int? id;
  int? chat_id;
  int? sender_id;
  int? receiver_id;
  String? sender_name;
  String? content;
  dynamic created_at;
  dynamic? read_at;
  dynamic? media;

  factory chatMessage.fromJson(Map<String, dynamic> json) => chatMessage(
      id: json["id"],
      chat_id: json["chat_id"],
      sender_id: json["sender_id"],
      receiver_id: json["receiver_id"],
      sender_name: json["sender_name"],
      content: json["content"],
      created_at: json["created_at"],
      read_at: json["read_at"],
      media: json["media"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chat_id,
        "sender_id": sender_id,
        "receiver_id": receiver_id,
        "sender_name": sender_name,
        "content": content,
        "created_at": created_at,
        "read_at": read_at,
        "media": media,
      };
}
