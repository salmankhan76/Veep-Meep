import 'package:veep_meep/features/data/models/responses/get_messages_response.dart';
import 'package:veep_meep/features/data/models/responses/send_message_response.dart';
import 'package:veep_meep/features/data/models/responses/veeped_users_response.dart';

import '../base_state.dart';

abstract class ChatState extends BaseState<ChatState> {}

class InitialChatState extends ChatState {}

class VeepedUsersSuccessState extends ChatState {
  final String message;
  final List<VeepedUser> output;

  VeepedUsersSuccessState({required this.message, required this.output});
}

class SendMsgSuccessState extends ChatState {
  final String message;
  final SendMsgData? sendMsgData;
  SendMsgSuccessState({required this.message, this.sendMsgData});
}

class GetAllMessagesSuccessState extends ChatState {
  final String message;
  final List<chatMessage> output;

  GetAllMessagesSuccessState({required this.message, required this.output});
}
