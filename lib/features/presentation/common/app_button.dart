import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_dimensions.dart';
import '../../../utils/enums.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final ButtonType buttonType;
  final Widget? prefixIcon;

  final Color buttonColor;
  final Color textColor;

  AppButton(
      {required this.buttonText,
        required this.onTapButton,
        this.width = 0,
        this.prefixIcon,
        this.buttonColor = AppColors.colorBlue,
        this.textColor = AppColors.colorGray100,
        this.buttonType = ButtonType.ENABLED});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  Color _buttonColor = AppColors.colorBlue;

  @override
  void initState() {
    _buttonColor = widget.buttonColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: MouseRegion(
        onEnter: (e){
          setState(() {
            _buttonColor = AppColors.colorGreen;
          });
        },
        onExit: (e){
          setState(() {
            _buttonColor = AppColors.colorPrimary;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          width: widget.width == 0 ? double.infinity : widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(AppConstants.UI_COMPONENT_PADDING)),
            color: widget.buttonType == ButtonType.ENABLED
                ? _buttonColor
                : AppColors.colorGray400,
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
                          ? widget.textColor
                          : AppColors.colorGray600,
                      fontWeight: FontWeight.w700,
                      fontSize:AppDimensions.kFontSize14),
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