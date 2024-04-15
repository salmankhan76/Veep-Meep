class MessageEntity {
  final int messageType;
  final String message;
  final DateTime dateTime;
  final String? img;

  MessageEntity({
    required this.messageType,
    required this.message,
    required this.dateTime,
    this.img,
  });
}
