import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class AppDivider extends StatelessWidget {
  final String? text;

  AppDivider({this.text});

  @override
  Widget build(BuildContext context) {
    return text != null ? _withText() : _withoutText();
  }

  Widget _withText() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            color: AppColors.colorDisableWidget,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            text!,
            style: const TextStyle(fontSize: 14, color: AppColors.fontLabelGray),
          ),
        ),
        const Expanded(
          child: Divider(
            height: 1,
            color: AppColors.colorDisableWidget,
          ),
        ),
      ],
    );
  }

  Widget _withoutText() {
    return const Divider(
      height: 1,
      color: AppColors.colorDisableWidget,
    );
  }
}
