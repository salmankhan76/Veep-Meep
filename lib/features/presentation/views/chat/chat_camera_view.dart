import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:veep_meep/features/presentation/bloc/base_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/base_event.dart';
import 'package:veep_meep/features/presentation/bloc/base_state.dart';
import 'package:veep_meep/features/presentation/views/base_view.dart';
import 'package:veep_meep/utils/app_colors.dart';
import 'package:veep_meep/utils/app_mediaQuery.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatCameraView extends BaseView {
  ChatCameraView({Key? key}) : super(key: key);

  @override
  State<ChatCameraView> createState() => _ChatCameraViewState();
}

class _ChatCameraViewState extends State<ChatCameraView> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    // TODO: Implement the appropriate bloc instance for this view
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeControllerFuture == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.colorGreen,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_cameraController!),
          Positioned(
            top: kheight(context) * 0.05,
            left: kwidth(context) * 0.03,
            child: Container(
              padding: EdgeInsets.all(kwidth(context) * 0.001),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: IconButton(
                icon: Icon(
                  FontAwesome.arrow_left,
                  color: Colors.white,
                  size: kwidth(context) * 0.06,
                ),
                onPressed: () => Navigator.of(context).pop(context),
              ),
            ),
          ),
          Positioned(
            top: kheight(context) * 0.05,
            right: kwidth(context) * 0.03,
            child: Container(
              padding: EdgeInsets.all(kwidth(context) * 0.001),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: IconButton(
                icon: Icon(
                  FontAwesome.camera_rotate,
                  color: Colors.white,
                  size: kwidth(context) * 0.06,
                ),
                onPressed: _onCameraFlipButtonPressed,
              ),
            ),
          ),
          Positioned(
            top: kheight(context) * 0.9,
            right: kwidth(context) * 0.4,
            child: Container(
              padding: EdgeInsets.all(kwidth(context) * 0.03),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: IconButton(
                icon: Icon(
                  FontAwesome.camera,
                  color: Colors.white,
                  size: kwidth(context) * 0.09,
                ),
                onPressed: _onCaptureButtonPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _cameraController = CameraController(
          cameras[0],
          ResolutionPreset.ultraHigh,
        );
        _initializeControllerFuture = _cameraController?.initialize();
        await _initializeControllerFuture;
        setState(() {});
      } else {
        throw Exception('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _onCaptureButtonPressed() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile imageFile = await _cameraController!.takePicture();
        // Process the captured image file as needed
        // For example, you can display it in a new screen or upload it to a server

        // You can also access the path of the image file using imageFile.path
      } catch (e) {
        print('Error capturing image: $e');
      }
    }
  }

  void _onCameraFlipButtonPressed() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final lensDirection = _cameraController!.description.lensDirection;
      CameraDescription? newCamera;

      if (lensDirection == CameraLensDirection.back) {
        newCamera = await _getCamera(CameraLensDirection.front);
      } else {
        newCamera = await _getCamera(CameraLensDirection.back);
      }

      if (newCamera != null) {
        await _cameraController!.dispose();
        _cameraController =
            CameraController(newCamera, ResolutionPreset.ultraHigh);
        await _cameraController!.initialize();
        setState(() {});
      }
    }
  }

  Future<CameraDescription?> _getCamera(CameraLensDirection direction) async {
    final cameras = await availableCameras();
    for (final camera in cameras) {
      if (camera.lensDirection == direction) {
        return camera;
      }
    }
    return null;
  }
}
