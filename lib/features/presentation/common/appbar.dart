import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class VeepMeepAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? goBackEnabled;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? titleSize;

  VeepMeepAppBar(
      {this.title = '',
      this.titleSize,
      this.actions,
      this.backgroundColor,
      this.fontColor,
      this.goBackEnabled = true,
      this.onBackPressed})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super();

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        title,
        style: TextStyle(
          color: AppConstants.kIsBizAccount
              ? AppColors.colorBlue
              : fontColor ?? AppColors.colorGray800,
          fontWeight: FontWeight.w700,
          fontSize: titleSize ?? AppDimensions.kFontSize24,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.fontColorWhite,
      actions: actions,
      elevation: 0,
      centerTitle: true,
      leading: goBackEnabled!
          ? InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else {
                  Navigator.pop(context);
                }
              },
              child: Icon(
                Icons.arrow_back,
                color: AppConstants.kIsBizAccount
                    ? AppColors.colorGreen
                    : AppColors.colorBlue,
                size: 30,
              ))
          : const SizedBox.shrink(),
    );
  }
}
