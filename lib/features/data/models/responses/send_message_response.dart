import 'dart:convert';

SendMsgResponse sendMsgFromJson(String str) =>
    SendMsgResponse.fromJson(json.decode(str));

class SendMsgResponse {
  bool success;
  String message;
  SendMsgData? output;

  SendMsgResponse({
    required this.success,
    required this.message,
    required this.output,
  });

  factory SendMsgResponse.fromJson(Map<String, dynamic> json) =>
      SendMsgResponse(
        success: json["success"],
        message: json["message"],
        output: json["output"] != null
            ? SendMsgData.fromJson(json["output"])
            : null,
      );
}

class SendMsgData {
  int? id;
  int? chat_id;
  int? sender_id;
  int? receiver_id;
  String? sender_name;
  String? content;
  int? media_id;
  String? path;
  String? created_at;
  String? read_at;

  SendMsgData({
    this.id,
    this.chat_id,
    this.sender_id,
    this.receiver_id,
    this.sender_name,
    this.content,
    this.media_id,
    this.path,
    this.created_at,
    this.read_at,
  });

  factory SendMsgData.fromJson(Map<String, dynamic> json) => SendMsgData(
        id: json["id"],
        chat_id: json["chat_id"],
        sender_id: json["sender_id"],
        receiver_id: json["receiver_id"],
        sender_name: json["sender_name"],
        content: json["content"],
        media_id: json["media_id"],
        path: json["path"],
        created_at: json["created_at"],
        read_at: json["read_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chat_id,
        "sender_id": sender_id,
        "receiver_id": receiver_id,
        "sender_name": sender_name,
        "content": content,
        "media_id": media_id,
        "path": path,
        "created_at": created_at,
        "read_at": read_at,
      };
}
