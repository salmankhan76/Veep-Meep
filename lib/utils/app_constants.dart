import 'package:flutter/material.dart';
import 'package:veep_meep/features/data/models/responses/veep_data_response.dart';
class AppConstants {
  static final String appName = 'Veep Meep';
  static double UI_PADDING = 20.0;
  static double LOADING_PROGRESS = 0;
  static EdgeInsets appPadding = EdgeInsets.all(
      AppConstants.UI_PADDING,
  );

  static VeepData? profileData;
  static double UI_COMPONENT_PADDING = 25;
  static bool kIsBizAccount = false;

  static Gradient COMMON_UI_GRADIENT = const LinearGradient(
      colors: [
        Colors.white,
        Color(0xFFE1E1E1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.11, 0.58]);
}