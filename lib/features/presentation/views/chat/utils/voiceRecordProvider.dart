import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class VoiceMessageProvider extends ChangeNotifier {
  final Function(bool cancel) handleRecord;
  final VoidCallback onSlideToCancelRecord;

  final double cancelPosition;

  final Record _record = Record();
  double _position = 0;
  int _duration = 0;
  bool _isRecording = false;
  int _recordTime = 0;
  double _height = 70;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  /// getters
  int get duration => _duration;
  bool get isRecording => _isRecording;
  int get recordTime => _recordTime;

  /// setters
  set height(double val) => _height = val;

  Permission micPermission = Permission.microphone;
  VoiceMessageProvider({
    required this.handleRecord,
    required this.onSlideToCancelRecord,
    required this.cancelPosition,
  });

  /// animated button on LongPress
  void onAnimatedButtonLongPress() async {
    // HapticFeedback.heavyImpact();
    final permissionStatus = await micPermission.request();

    if (permissionStatus.isGranted) {
      _stopWatchTimer.onStartTimer();
      _stopWatchTimer.rawTime.listen((value) {
        _recordTime = value;

        print('rawTime $value ${StopWatchTimer.getDisplayTime(_recordTime)}');
        notifyListeners();
      });

      recordAudio();

      _isRecording = true;
      notifyListeners();
    }
    if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  /// animated button on Long Press Move Update
  void onAnimatedButtonLongPressMoveUpdate(
      LongPressMoveUpdateDetails details) async {
    if (_isRecording == true) {
      _duration = 0;
      _position = details.localPosition.dx * -1;
      notifyListeners();
    }
  }

  /// animated button on Long Press End
  void onAnimatedButtonLongPressEnd(LongPressEndDetails details) async {
    final source = await stopRecord();
    // Stop
    _stopWatchTimer.onStopTimer();

    // Reset
    _stopWatchTimer.onResetTimer();

    if (await micPermission.isGranted) {
      if (_position > cancelPosition - _height || source == null) {
        handleRecord(true);

        onSlideToCancelRecord();
      } else {
        handleRecord(false);
      }

      _duration = 600;
      _position = 0;
      _isRecording = false;
      notifyListeners();
    }
  }

  /// function used to record audio
  void recordAudio() async {
    if (await _record.isRecording()) {
      _record.stop();
    }

    await _record.start(
      path: '/myFile.m4a', // required
      bitRate: 128000, // by default
      // sampleRate: 44100, // by default
    );
  }

  /// function used to stop recording
  /// and returns the record path as a string

  Future<String?> stopRecord() async {
    return await _record.stop();
  }

  /// get the animated button position
  double getPosition() {
    if (_position < 0) {
      return 0;
    } else if (_position > cancelPosition - _height) {
      return cancelPosition - _height;
    } else {
      return _position;
    }
  }
}
