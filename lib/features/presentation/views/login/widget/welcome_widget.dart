import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_dimensions.dart';

class WelcomeWidget extends StatelessWidget {
  String text;
  String description;

  WelcomeWidget({super.key, required this.text, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      Padding(
        padding:  EdgeInsets.only(left: 20.w),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppConstants.kIsBizAccount
                    ? AppColors.colorBlue
                    : AppColors.fontColorGray,
                fontSize: AppDimensions.kFontSize16)),
      ),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppConstants.kIsBizAccount
                  ? AppColors.colorYellow
                  : AppColors.fontColorWhite,
              border: Border.all(
                  color: AppConstants.kIsBizAccount
                      ? AppColors.colorBlue
                      : AppColors.colorBorder)),
          height: 100.h,
          width: 150.w,
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(description,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppDimensions.kFontSize12,
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorBlue
                          : AppColors.fontColorGray)),
            ),
          ),
        ),
      )
    ]);
  }
}
