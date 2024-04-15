import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show RawResourceAndroidNotificationSound;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veep_meep/core/network/network_config.dart';
import 'package:veep_meep/features/data/datasources/shared_preference.dart';
import 'package:veep_meep/features/data/models/responses/get_messages_response.dart';
import 'package:veep_meep/features/domain/entities/contacts_entity.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_event.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_state.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/features/presentation/views/chat/chat_inner_view.dart';
import 'package:veep_meep/features/presentation/views/chat/widgets/chat_component.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_search_component.dart';
import '../base_view.dart';

class AllChatView extends BaseView {
  @override
  State<AllChatView> createState() => _AllChatViewState();
}

class _AllChatViewState extends BaseViewState<AllChatView> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AppSharedData appSharedData;
  late PusherClient pusher;
  final player = AudioPlayer();

  var chatBloc = injection<ChatBloc>();

  List<ContactEntity> contactEntity = [];

  @override
  void initState() {
    chatBloc.add(GetVeepedUsersEvent());
    super.initState();
    initSharedData();
  }

  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> initSharedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    appSharedData = AppSharedData(preferences);
    initializeNotifications();
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
            '${NetworkConfig.getNetworkUrl()}broadcasting/auth',
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

  void subscribeToChannel() async {
    try {
      Channel channel_chat_receiver = pusher.subscribe(
        'private-private.chat.' + appSharedData.getUserId().toString(),
      );

      // Channel chat_receiver_presence = pusher.subscribe(
      //   'presence-presence-chat',
      // );

      // chat_receiver_presence.bind('client-online', (event) {
      //   print('Received event: ${event!.eventName}, data: ${event.data}');
      // });

      // chat_receiver_presence.bind('client-typing', (event) {
      //   print('Received event: ${event!.eventName}, data: ${event.data}');
      // });

      channel_chat_receiver.bind("chat.message", (PusherEvent? event) async {
        // print('Received event: ${event!.eventName}, data: ${event.data}');
        // Handle the event data
        final Map<String, dynamic> jsonDecodedRes =
            jsonDecode(event!.data.toString());

        ContactEntity desiredObject = contactEntity.firstWhere(
          (object) => object.userId == jsonDecodedRes["sender_id"],
          orElse: () => ContactEntity(
            userId: -1,
            name: '',
            about: '',
            img: '',
            isNotSeen: false,
            isOnline: false,
            lastActive: DateTime.now(),
            order_by: DateTime.now(),
            last_message:
                chatMessage(), // Replace `chatMessage()` with the appropriate default constructor for your `chatMessage` class
          ),
        );

        setState(() {
          if (desiredObject.userId != -1) {
            contactEntity.remove(desiredObject);
            contactEntity.insert(
              0,
              ContactEntity(
                userId: desiredObject.userId,
                name: desiredObject.name,
                about: '',
                img: desiredObject.img,
                isNotSeen: desiredObject.isNotSeen,
                isOnline: desiredObject.isOnline,
                lastActive: desiredObject.lastActive,
                order_by: desiredObject.order_by,
                last_message: jsonDecodedRes,
              ),
            );
          }
        });

        await showNotification(desiredObject.last_message["id"],
            desiredObject.name, desiredObject.last_message["content"]);
      });

      // Timer.periodic(
      //   const Duration(seconds: 10),
      //   (timer) => chat_receiver_presence.trigger('client-online', {}),
      // );
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> showNotification(
      int message_id, String title, String message) async {
    player.play(AssetSource('sounds/chat-notifications.mp3'));
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'chat_notifications'), // specify the sound file
      playSound: true,
      enableLights: true,
      enableVibration: true,
      // icon: 'images/png/img_logo.mp3',
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message_id, // Notification ID
      title, // Notification title
      message, // Notification body
      platformChannelSpecifics, // Notification details
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Chat',
        backgroundColor: AppColors.fontColorWhite,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ChatBloc>(
            create: (_) => chatBloc,
          ),
        ],
        child: BlocListener<ChatBloc, BaseState<ChatState>>(
            listener: (_, state) {
              if (state is VeepedUsersSuccessState && state.output != null) {
                setState(() {
                  contactEntity.clear();

                  contactEntity.addAll(state.output.map((e) => ContactEntity(
                        userId: e.user_id!,
                        name: e.full_name ?? "",
                        about: "",
                        img: e.avatar ?? "",
                        isNotSeen: false,
                        isOnline: false,
                        lastActive: DateTime.now(),
                        order_by: DateTime.parse(e.order_by!),
                        last_message: e.last_message ?? {},
                      )));
                });
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 20, right: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          child: AppSearchComponent(
                              searchCriteria: AppSearchCriteria(
                                  dataset:
                                      contactEntity.map((e) => e.name).toList(),
                                  defaultValue: '',
                                  onSubmit: (query) {},
                                  title: 'Search Name')),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: contactEntity.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ChatComponent(
                                contactEntity: contactEntity[index],
                                tap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatInnerView(
                                              userId:
                                                  contactEntity[index].userId,
                                              username:
                                                  contactEntity[index].name,
                                              avatar: contactEntity[index].img,
                                            )),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return chatBloc;
  }
}
