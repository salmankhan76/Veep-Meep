import 'package:veep_meep/features/data/models/requests/send_message_request.dart';

import '../base_event.dart';

abstract class ChatEvent extends BaseEvent {}

class GetVeepedUsersEvent extends ChatEvent {
  GetVeepedUsersEvent();
}

class SendMessageEvent extends ChatEvent {
  final SendMsgRequest sendMsgRequest;

  SendMessageEvent({required this.sendMsgRequest});
}

class GetMessagesEvent extends ChatEvent {
  final int receiver_id;

  GetMessagesEvent({required this.receiver_id});
}
