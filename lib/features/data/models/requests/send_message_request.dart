import 'dart:convert';

SendMsgRequest sendMsgRequestFromJson(String str) =>
    SendMsgRequest.fromJson(json.decode(str));

String sendMsgRequestToJson(SendMsgRequest data) => json.encode(data.toJson());

class SendMsgRequest {
  int receiver_id;
  String content;
  dynamic media_id;

  SendMsgRequest({
    required this.receiver_id,
    required this.content,
    required this.media_id,
  });

  factory SendMsgRequest.fromJson(Map<String, dynamic> json) => SendMsgRequest(
        receiver_id: json["receiver_id"],
        content: json["content"],
        media_id: json["media_id"],
      );

  Map<String, dynamic> toJson() => {
        "receiver_id": receiver_id,
        "content": content,
        "media_id": media_id,
      };
}
