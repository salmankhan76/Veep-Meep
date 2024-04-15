import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimensions.dart';
import '../../../../domain/entities/user_option_entity.dart';

class UnselectedOptionUI extends StatelessWidget {
  final UserOptionEntity userOptionEntity;

  UnselectedOptionUI({required this.userOptionEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              userOptionEntity.optionName,
              style: TextStyle(
                fontSize: AppDimensions.kFontSize12,
                color: AppColors.colorGray800,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: userOptionEntity!.hasAmount! ? 15 : 13,
            ),
            Text(
              userOptionEntity!.hasAmount!
                  ? 'USD \$${userOptionEntity.amount}'
                  : userOptionEntity.numberOfWeeks.toString(),
              style: TextStyle(
                  color: AppColors.colorGray800,
                  fontSize: userOptionEntity!.hasAmount!
                      ? AppDimensions.kFontSize14
                      : AppDimensions.kFontSize26,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              userOptionEntity!.hasAmount! ? 'per month' : 'weeks',
              style: TextStyle(
                fontSize: AppDimensions.kFontSize12,
                color: AppColors.colorGray800,
              ),
            ),
          ],
        ),
        userOptionEntity!.hasAmount!
            ? Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    '${userOptionEntity!.numberOfContents} ${userOptionEntity!.numberOfContents! > 1 ? 'Continents' : 'Continent'}',
                    style: TextStyle(
                      fontSize: AppDimensions.kFontSize12,
                      color: AppColors.colorGray800,
                    ),
                  ),
                ],
              )
            : Text(
                'Free',
                style: TextStyle(
                    color: AppColors.colorGray800,
                    fontSize: AppDimensions.kFontSize14,
                    fontWeight: FontWeight.bold),
              ),
      ],
    );
  }
}
