import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../utils/app_colors.dart';

class AppDataComponent extends StatefulWidget {
  String title;
  String subtitle;
  Color? titleColor;
  Color? backgroundColor;
  Color? subtitleColor;
  double? dividerThickness;
  VoidCallback onTap;
  int? maxLength;

  AppDataComponent({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.maxLength,
    this.dividerThickness = 1,
    this.titleColor = AppColors.colorGray800,
    this.subtitleColor = AppColors.colorGray600,
    this.backgroundColor = AppColors.colorBorder,
  });

  @override
  State<AppDataComponent> createState() => _AppDataComponentState();
}

class _AppDataComponentState extends State<AppDataComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: double.infinity,
        color: widget.backgroundColor,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: widget.titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimensions.kFontSize18),
            ),
            const SizedBox(
              height: 08,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      widget.subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: widget.subtitleColor,
                          fontWeight: FontWeight.w400,
                          fontSize: AppDimensions.kFontSize16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: widget.dividerThickness ?? 1,
                      color: AppColors.colorGray700,
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.maxLength!=null,
                  child: Positioned(
                    bottom: 10,
                    child: Text(
                      widget.maxLength.toString(),
                      style: TextStyle(
                          color: AppColors.colorGray400,
                          fontSize: AppDimensions.kFontSize12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
