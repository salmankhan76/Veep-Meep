import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import 'app_subtitle_text.dart';
import 'app_title_text.dart';

class AppDataViewComponent extends StatefulWidget {
  String title;
  String subtitle;
  Color? titleColor;
  Color? subtitleColor;
  AppDataViewComponent({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleColor,
    this.subtitleColor = AppColors.colorBlue,
  }) : super(key: key);

  @override
  State<AppDataViewComponent> createState() => _AppDataViewComponentState();
}

class _AppDataViewComponentState extends State<AppDataViewComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.colorBorder,
      height: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTitleText(
            title: widget.title,
            color: widget.titleColor,
          ),
          const SizedBox(
            height: 08,
          ),
          AppSubText(
            subtitle: widget.subtitle,
            color: widget.subtitleColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 02,
            color: AppColors.colorGray700,
          ),
        ],
      ),
    );
  }
}
