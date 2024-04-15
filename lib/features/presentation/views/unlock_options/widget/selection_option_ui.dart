import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimensions.dart';
import '../../../../domain/entities/user_option_entity.dart';

class SelectedOptionUI extends StatelessWidget {
  final UserOptionEntity userOptionEntity;
  final bool isBiz;

  SelectedOptionUI({required this.userOptionEntity, this.isBiz = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.h,
      width: 125.w,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
              color: isBiz ? AppColors.colorBlue : AppColors.colorYellow,
              width: 4),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                isBiz ? AppColors.colorGray700 : AppColors.colorGreen,
                isBiz ? AppColors.colorGray700 : AppColors.colorBlue,
              ],
              stops: const [
                0.0,
                0.9
              ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: AppColors.fontColorWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
                child: Text(
              _getBanner(),
              style: TextStyle(
                  color: AppColors.colorGray800,
                  fontSize: AppDimensions.kFontSize10,
                  fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            userOptionEntity.optionName,
            style: TextStyle(
              fontSize: AppDimensions.kFontSize14,
              color: AppColors.fontColorWhite,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            userOptionEntity!.hasAmount!
                ? 'USD \$${userOptionEntity.amount}'
                : userOptionEntity.numberOfWeeks.toString(),
            style: TextStyle(
                color: AppColors.fontColorWhite,
                fontSize: AppDimensions.kFontSize16,
                fontWeight: FontWeight.bold),
          ),
          Text(
            userOptionEntity!.hasAmount! ? 'per month' : 'weeks',
            style: TextStyle(
              fontSize: AppDimensions.kFontSize14,
              color: AppColors.fontColorWhite,
            ),
          ),
          userOptionEntity!.hasAmount!
              ? Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '${userOptionEntity!.numberOfContents} ${userOptionEntity!.numberOfContents! > 1 ? 'Continents' : 'Continent'}',
                      style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        color: AppColors.fontColorWhite,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Free',
                  style: TextStyle(
                      color: AppColors.fontColorWhite,
                      fontSize: AppDimensions.kFontSize16,
                      fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }

  String _getBanner() {
    switch (userOptionEntity.userOptionType) {
      case UserOptionType.PEACH:
      case UserOptionType.POTATO:
        return 'MOST POPULAR';
      case UserOptionType.MANGO:
      case UserOptionType.PUMPKIN:
        return 'MORE REACH';
      case UserOptionType.TRY:
        return 'TEST DRIVE';
    }
  }
}
