import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veep_meep/core/network/network_config.dart';
import 'package:veep_meep/core/service/app_permission.dart';
import 'package:veep_meep/core/service/dependency_injection.dart';
import 'package:veep_meep/features/data/datasources/shared_preference.dart';
import 'package:veep_meep/features/data/models/requests/send_message_request.dart';
import 'package:veep_meep/features/presentation/bloc/base_state.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_event.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_state.dart';
import 'package:veep_meep/features/presentation/views/chat/utils/voiceRecordProvider.dart';
import 'package:veep_meep/utils/app_mediaQuery.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimensions.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/navigation_routes.dart';

class ChatTextFieldComponent extends StatefulWidget {
  final VoiceMessageProvider provider;
  final Function(String) callback;
  final int userId;

  const ChatTextFieldComponent({
    Key? key,
    required this.provider,
    required this.userId,
    required this.callback,
  }) : super(key: key);

  @override
  _ChatTextFieldComponentState createState() => _ChatTextFieldComponentState();
}

class _ChatTextFieldComponentState extends State<ChatTextFieldComponent>
    with WidgetsBindingObserver {
  final ImagePicker _picker = ImagePicker();
  var bloc = injection<ChatBloc>();
  final TextEditingController _chatTextFieldController =
      TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isClickedOnTypeField = false;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  late AppSharedData appSharedData;
  late PusherClient pusher;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    // Get the list of available cameras.
    availableCameras().then((cameras) {
      // Select the first camera from the list.
      final camera = cameras.first;

      // Initialize the camera controller.
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      // Initialize the camera controller future.
      _initializeControllerFuture = _controller.initialize();
    });

    initSharedData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  Future<void> initSharedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    appSharedData = AppSharedData(preferences);
    // connectToPusher();
    // subscribeToChannel();
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
      Channel chat_receiver_presence = pusher.subscribe(
        'presence-presence-chat',
      );

      chat_receiver_presence.bind('client-online', (event) {
        print('Received event: ${event!.eventName}, data: ${event.data}');
      });

      // Timer.periodic(
      //   const Duration(seconds: 10),
      //   (timer) => chat_receiver_presence.trigger('client-online', {}),
      // );
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Widget _buildCameraPreview() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the camera preview.
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading spinner.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void openCamera(BuildContext context) async {
    try {
      Navigator.pushNamed(context, Routes.kChatCameraView);
    } catch (e) {}
  }

  void openImageGallery(BuildContext context) async {
    try {
      Navigator.pushNamed(context, Routes.kChatGalleryImageView);
    } catch (e) {}
  }

  void openVideoGallery(BuildContext context) async {
    try {
      Navigator.pushNamed(context, Routes.kChatGalleryVideoView);
    } catch (e) {}
  }

  void _handleTapOutside(BuildContext context) {
    _textFieldFocusNode.unfocus();
    setState(() {
      _isClickedOnTypeField = false;
    });
  }

  void hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void submitChatMessage() {
    if (_chatTextFieldController.value.text != "") {
      bloc.add(SendMessageEvent(
          sendMsgRequest: SendMsgRequest(
        content: _chatTextFieldController.value.text,
        receiver_id: widget.userId,
        media_id: null,
      )));

      bloc.add(GetMessagesEvent(receiver_id: widget.userId));
      widget.callback(_chatTextFieldController.value.text);
      setState(() {
        _chatTextFieldController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _handleTapOutside(context),
        child: BlocProvider<ChatBloc>(
            create: (_) => bloc,
            child: BlocListener<ChatBloc, BaseState<ChatState>>(
              listener: (_, state) {},
              child: Container(
                height: kheight(context) * 0.09,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: AppColors.colorGray50,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            !_isClickedOnTypeField
                                ? Icons.add_circle
                                : Icons.arrow_downward,
                            color: AppColors.colorBlue,
                            size: 25,
                          ),
                        ),
                        onTap: () {
                          hideKeyboard();
                          setState(() {
                            _isClickedOnTypeField = !_isClickedOnTypeField;
                          });
                        },
                      ),
                      if (!_isClickedOnTypeField) const SizedBox(width: 5),
                      if (!_isClickedOnTypeField)
                        InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.colorBlue,
                              size: 25,
                            ),
                          ),
                          onTap: () async {
                            AppPermissionManager.requestCameraPermission(
                              context,
                              () async {
                                // Navigator.pushNamed(
                                //     context, Routes.kChatCameraPreView);
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);
                                if (photo != null) {
                                  // File imageFile = File(pickedFile.path);
                                }
                              },
                            );
                          },
                        ),
                      if (!_isClickedOnTypeField) const SizedBox(width: 5),
                      if (!_isClickedOnTypeField)
                        InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.image,
                              color: AppColors.colorBlue,
                              size: 25,
                            ),
                          ),
                          onTap: () async {
                            AppPermissionManager
                                .requestExternalStoragePermission(
                              context,
                              () async {
                                final List<XFile> pickedFileList =
                                    await _picker.pickMultipleMedia(
                                        maxWidth: kwidth(context),
                                        maxHeight: kheight(context),
                                        imageQuality: 100,
                                        requestFullMetadata: true);
                                if (pickedFileList != null &&
                                    pickedFileList.length > 0) {
                                  // File imageFile = File(pickedFile.path);
                                }
                              },
                            );
                          },
                        ),
                      // if (!_isClickedOnTypeField) const SizedBox(width: 5),
                      // if (!_isClickedOnTypeField)
                      //   InkWell(
                      //     child: const Padding(
                      //       padding: EdgeInsets.all(5.0),
                      //       child: Icon(
                      //         Icons.video_library,
                      //         color: AppColors.colorBlue,
                      //         size: 25,
                      //       ),
                      //     ),
                      //     onTap: () {
                      //       AppPermissionManager
                      //           .requestExternalStoragePermission(
                      //         context,
                      //         () => openVideoGallery(context),
                      //       );
                      //     },
                      //   ),
                      if (!_isClickedOnTypeField) const SizedBox(width: 5),
                      if (!_isClickedOnTypeField)
                        InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.mic,
                              color: AppColors.colorBlue,
                              size: 25,
                            ),
                          ),
                          onTap: () async {
                            AppPermissionManager.requestMicrophonePermission(
                              context,
                              () async {
                                if (widget.provider.isRecording) {
                                  widget.provider
                                      .stopRecord()
                                      .then((recordPath) {
                                    if (recordPath != null) {}
                                  });
                                } else {
                                  widget.provider.onAnimatedButtonLongPress();
                                }
                              },
                            );
                          },
                        ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextField(
                            focusNode: _textFieldFocusNode,
                            controller: _chatTextFieldController,
                            style: TextStyle(
                              fontSize: AppDimensions.kFontSize14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorGray700,
                            ),
                            onTap: () {
                              setState(() {
                                _isClickedOnTypeField = true;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(14),
                              isDense: true,
                              counterText: "",
                              hintText: 'Type a message',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorBlue, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorGray500, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorGray500, width: .0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              prefixIcon: GestureDetector(
                                child: const Icon(
                                  Icons.mood,
                                  color: AppColors.colorGray500,
                                  size: 30,
                                ),
                              ),
                              prefixIconConstraints:
                                  const BoxConstraints(minWidth: 45),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  submitChatMessage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    AppImages.appVeepMeep2,
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                color: AppColors.colorGray500,
                              ),
                              fillColor: AppColors.colorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
