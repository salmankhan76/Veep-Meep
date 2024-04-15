import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatefulWidget {
  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.first;

      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      // Handle camera initialization error
      print('Error initializing camera: $e');
    }
  }

  Widget _buildCameraPreview() {
    if (_initializeControllerFuture == null || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_controller != null && _controller.value.isInitialized) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: Text('Failed to initialize camera'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Widget'),
      ),
      body: _buildCameraPreview(),
    );
  }
}
