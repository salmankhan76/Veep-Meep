import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:veep_meep/core/network/network_config.dart';
import 'package:veep_meep/features/data/datasources/shared_preference.dart';
import 'package:veep_meep/features/domain/entities/chat_data_entity.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_event.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_state.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/features/presentation/views/chat/widgets/chat_textField_component.dart';
import 'package:veep_meep/features/presentation/views/chat/widgets/message_view.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/features/presentation/views/chat/utils/voiceRecordProvider.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../domain/entities/message_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class ChatInnerView extends BaseView {
  final int userId;
  final String username;
  final String avatar;
  ChatInnerView({
    super.key,
    required this.userId,
    required this.username,
    required this.avatar,
  });

  @override
  State<ChatInnerView> createState() => _ChatInnerViewState();
}

class _ChatInnerViewState extends BaseViewState<ChatInnerView> {
  late AppSharedData appSharedData;

  late PusherClient pusher;
  final player = AudioPlayer();

  var chatBloc = injection<ChatBloc>();
  final ChatDataEntity chatDataEntity = ChatDataEntity(
    messageEntity: [],
  );
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    chatBloc.add(GetMessagesEvent(receiver_id: widget.userId));
    initSharedData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> initSharedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    appSharedData = AppSharedData(preferences);
    connectToPusher();
    subscribeToChannel();
  }

  void connectToPusher() {
    try {
      pusher = PusherClient(
        'webmotech',
        PusherOptions(
          host: NetworkConfig.getHost(),
          maxReconnectGapInSeconds: 2,
          // wsPort: 6001,
          encrypted: true,
          wssPort: 6001,
          auth: PusherAuth(
            '${NetworkConfig.getNetworkUrl()}/broadcasting/auth',
            headers: {
              'Authorization': 'Bearer ' + appSharedData.getAppToken()!,
            },
          ),
        ),
        enableLogging: true,
        autoConnect: false,
      );

      pusher.connect();

      pusher.onConnectionStateChange((state) {
        print('Pusher connection state: $state');
        print(state?.currentState.toString());
      });

      pusher.onConnectionError((error) {
        print("error: ${error?.exception}");
      });
    } catch (e) {
      print('ERROR: $e');
    }
  }

  void subscribeToChannel() {
    try {
      Channel channel_chat_receiver = pusher.subscribe(
          'private-private.chat.' + appSharedData.getUserId().toString());

      channel_chat_receiver.bind("chat.message", (PusherEvent? event) {
        // Handle the event data
        final Map<String, dynamic> jsonDecodedRes =
            jsonDecode(event!.data.toString());
        setState(() {
          chatDataEntity.messageEntity.add(
            MessageEntity(
                messageType:
                    jsonDecodedRes["receiver_id"] == widget.userId ? 0 : 1,
                message: jsonDecodedRes["content"] ?? "",
                dateTime: DateTime.now().subtract(const Duration(days: 2))),
          );
          chatDataEntity.messageEntity
              .sort((a, b) => b.dateTime.compareTo(a.dateTime));
        });

        // player.play(AssetSource('sounds/message_tone.wav'));

        // Delay the scrollToBottom operation
        Future.delayed(Duration(milliseconds: 300), () {
          scrollToBottom();
        });
        // print('Received event: ${event!.eventName}, data: ${event.data}');
      });
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    chatBloc.close();
    // Unsubscribe from channel
    pusher.unsubscribe('chat.' + appSharedData.getUserId().toString());
    // Disconnect from pusher service
    pusher.disconnect();
    super.dispose();
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  scrollToBottom() {
    // Scroll to the bottom of the ListView when a new message is received
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  final VoiceMessageProvider provider = VoiceMessageProvider(
    handleRecord: (bool cancel) {
      // Handle the recording result (cancel or send)
      if (cancel) {
        print('Recording cancelled');
      } else {
        print('Recording sent');
      }
    },
    onSlideToCancelRecord: () {
      // Handle slide to cancel record
      print('Slide to cancel record');
    },
    cancelPosition: 200, // Set the desired cancel position
  );

  void updateChildWidgetState(String content) {
    setState(() {
      chatDataEntity.messageEntity.add(
        MessageEntity(
            messageType: 0, message: content, dateTime: DateTime.now()),
      );
      chatDataEntity.messageEntity
          .sort((a, b) => b.dateTime.compareTo(a.dateTime));
    });
    // Delay the scrollToBottom operation
    Future.delayed(Duration(milliseconds: 300), () {
      scrollToBottom();
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.colorGray100,
        appBar: _scrollPosition == 0
            ? VeepMeepAppBar(
                backgroundColor: AppColors.colorGray100,
              )
            : VeepMeepAppBar(
                backgroundColor: AppColors.colorGray100,
                title: widget.username,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: AppColors.colorBlue,
                      radius: 20,
                      child: CircleAvatar(
                        radius: 18,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.avatar))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        body: BlocProvider<ChatBloc>(
          create: (_) => chatBloc,
          child: BlocListener<ChatBloc, BaseState<ChatState>>(
              listener: (_, state) {
                if (state is GetAllMessagesSuccessState &&
                    state.output != null) {
                  setState(() {
                    chatDataEntity.messageEntity.clear();
                    chatDataEntity.messageEntity.addAll(state.output.map(
                      (e) => MessageEntity(
                          messageType: e.receiver_id == widget.userId ? 0 : 1,
                          message: e.content!,
                          dateTime: DateTime.parse(e.created_at)),
                    ));
                    chatDataEntity.messageEntity
                        .sort((a, b) => b.dateTime.compareTo(a.dateTime));
                  });

                  // Delay the scrollToBottom operation
                  Future.delayed(Duration(milliseconds: 300), () {
                    scrollToBottom();
                  });
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 20, right: 20, bottom: 0),
                          child: ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            reverse: false,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.colorBlue,
                                          radius: 70,
                                          child: CircleAvatar(
                                            radius: 68,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          widget.avatar))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${widget.username}, ",
                                              style: TextStyle(
                                                  color: AppColors.titleColor,
                                                  fontSize:
                                                      AppDimensions.kFontSize24,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              23.toString(),
                                              style: TextStyle(
                                                  color: AppColors.titleColor,
                                                  fontSize:
                                                      AppDimensions.kFontSize24,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]),
                                      Text(
                                        'You are friends on veep meep',
                                        style: TextStyle(
                                            color: AppColors.colorGray700,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                AppDimensions.kFontSize18),
                                      ),
                                      Text(
                                        'California, USA',
                                        style: TextStyle(
                                            color: AppColors.colorGray500,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                AppDimensions.kFontSize16),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Say hi to your new veep meep friend, ${widget.username.split(' ').elementAt(0)}',
                                        style: TextStyle(
                                            color: AppColors.colorGray600,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                AppDimensions.kFontSize16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GroupedListView<MessageEntity, DateTime>(
                                reverse: true,
                                floatingHeader: true,
                                elements: chatDataEntity.messageEntity,
                                groupBy: (message) => DateTime(
                                  message.dateTime.year,
                                  message.dateTime.month,
                                  message.dateTime.day,
                                ),
                                groupHeaderBuilder: (MessageEntity message) =>
                                    SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.fontColorWhite,
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.fontColorWhite),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          DateFormat.yMMMd().format(
                                                      message.dateTime) ==
                                                  DateFormat.yMMMd()
                                                      .format(DateTime.now())
                                              ? 'Today'
                                              : DateFormat.yMMMd()
                                                  .format(message.dateTime),
                                          style: TextStyle(
                                              color: AppColors.titleColor,
                                              fontSize:
                                                  AppDimensions.kFontSize12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, MessageEntity message) {
                                  return MessageView(
                                    messageEntity: message,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return ChatTextFieldComponent(
                        provider: provider,
                        userId: widget.userId,
                        callback: updateChildWidgetState,
                      );
                    },
                  )
                ],
              )),
        ));
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return chatBloc;
  }
}
