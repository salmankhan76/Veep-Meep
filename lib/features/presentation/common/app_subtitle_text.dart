import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class AppSubText extends StatefulWidget {
  String subtitle;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  TextAlign? textAlign;
  AppSubText({
    Key? key,
    required this.subtitle,
    this.color = AppColors.colorGray700,
    this.fontWeight,
    this.fontSize,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  State<AppSubText> createState() => _AppSubTextState();
}

class _AppSubTextState extends State<AppSubText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.subtitle,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: widget.color,
        fontWeight: widget.fontWeight ?? FontWeight.w400,
        fontSize: widget.fontSize ?? AppDimensions.kFontSize16,
      ),
    );
  }
}
