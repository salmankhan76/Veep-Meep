import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionManager {
  static requestCameraPermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.camera.request().isGranted) {
      onGranted();
    }
  }

  static requestExternalStoragePermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.storage.request().isGranted) {
      onGranted();
    }
  }

  static requestGalleryPermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.mediaLibrary.request().isGranted) {
      onGranted();
    }
  }

  static requestMicrophonePermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.microphone.request().isGranted) {
      onGranted();
    }
  }
}
