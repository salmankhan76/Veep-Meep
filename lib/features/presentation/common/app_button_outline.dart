import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/enums.dart';

class AppButtonOutline extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final ButtonType buttonType;
  final Widget? prefixIcon;

  const AppButtonOutline(
      {required this.buttonText,
      required this.onTapButton,
      this.width = 0,
      this.prefixIcon,
      this.buttonType = ButtonType.ENABLED});

  @override
  State<AppButtonOutline> createState() => _AppButtonOutlineState();
}

class _AppButtonOutlineState extends State<AppButtonOutline> {
  Color _buttonColor = AppColors.colorBlue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: MouseRegion(
        onEnter: (e) {
          setState(() {
            _buttonColor = AppColors.colorHover;
          });
        },
        onExit: (e) {
          setState(() {
            _buttonColor = AppColors.colorPrimary;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          width: widget.width == 0 ? double.infinity : widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(AppConstants.UI_COMPONENT_PADDING)),
            color: AppConstants.kIsBizAccount
                ? AppColors.colorYellow
                : AppColors.colorPrimary,
            border: Border.all(
                color: widget.buttonType == ButtonType.ENABLED
                    ? AppConstants.kIsBizAccount
                        ? AppColors.colorGreen
                        : _buttonColor
                    : _buttonColor.withOpacity(.6),
                width: 1),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.prefixIcon ?? const SizedBox.shrink(),
                widget.prefixIcon != null
                    ? const SizedBox(
                        width: 15,
                      )
                    : const SizedBox.shrink(),
                Text(
                  widget.buttonText,
                  style: TextStyle(
                      color: widget.buttonType == ButtonType.ENABLED
                          ? AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : _buttonColor
                          : _buttonColor,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.kFontSize14),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        if (widget.buttonType == ButtonType.ENABLED) {
          if (widget.onTapButton != null) {
            widget.onTapButton();
          }
        }
      },
    );
  }
}
