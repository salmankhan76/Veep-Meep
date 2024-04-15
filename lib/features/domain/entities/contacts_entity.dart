import 'package:veep_meep/features/data/models/responses/get_messages_response.dart';

class ContactEntity {
  final int userId;
  final String img;
  final String name;
  final String about;
  final DateTime lastActive;
  final DateTime order_by;
  bool isNotSeen;
  bool isOnline;
  dynamic last_message;

  ContactEntity({
    required this.userId,
    required this.img,
    required this.name,
    required this.about,
    required this.isOnline,
    required this.lastActive,
    required this.order_by,
    required this.isNotSeen,
    required this.last_message,
  });
}
