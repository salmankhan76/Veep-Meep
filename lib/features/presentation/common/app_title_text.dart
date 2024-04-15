// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class AppTitleText extends StatefulWidget {
  String title;
  Color? color;
  double? fontsize;
  FontWeight? fontWeight;

  AppTitleText(
      {Key? key,
      required this.title,
      this.fontsize,
      this.color,
      this.fontWeight})
      : super(key: key);

  @override
  State<AppTitleText> createState() => _AppTitleTextState();
}

class _AppTitleTextState extends State<AppTitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
          color: widget.color ?? AppColors.colorGray800,
          fontWeight: widget.fontWeight ?? FontWeight.w600,
          fontSize: widget.fontsize ?? AppDimensions.kFontSize18),
    );
  }
}
