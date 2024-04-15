import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:veep_meep/utils/app_colors.dart';

import '../../../utils/app_constants.dart';

class AppSwitch extends StatefulWidget {
  bool value;
  Color? backgroundColor;
  void Function(bool) onChanged;

  AppSwitch(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.backgroundColor})
      : super(key: key);

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: FlutterSwitch(
        activeSwitchBorder: Border.all(
            width: 4,
            color: AppConstants.kIsBizAccount
                ? AppColors.colorGreen
                : AppColors.colorBlue),
        inactiveSwitchBorder:
            Border.all(width: 4, color: AppColors.colorGray700),
        value: widget.value,
        onToggle: widget.onChanged,
        activeColor: widget.backgroundColor ??
            (AppConstants.kIsBizAccount
                ? AppColors.colorYellow
                : AppColors.colorBackground),
        inactiveColor: AppColors.colorBorder,
        inactiveToggleColor: AppColors.colorGray700,
        toggleColor: AppConstants.kIsBizAccount
            ? AppColors.colorGreen
            : AppColors.colorBlue,
      ),
    );
  }
}
