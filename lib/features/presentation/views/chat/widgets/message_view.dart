import 'package:flutter/material.dart';
import 'package:veep_meep/features/presentation/views/chat/widgets/sender_view.dart';
import 'package:veep_meep/features/presentation/views/chat/widgets/reciever_view.dart';

import '../../../../domain/entities/message_entity.dart';

class MessageView extends StatelessWidget {
  final MessageEntity messageEntity;

  MessageView({required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: messageEntity.messageType == 0
          ? SenderView(messageEntity: messageEntity)
          : RecieverView(messageEntity: messageEntity,),
    );
  }
}
