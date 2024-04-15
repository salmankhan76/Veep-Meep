import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/app_images.dart';

import '../../../../utils/app_colors.dart';

class MatchView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Material(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border:
                          Border.all(color: AppColors.colorGray900, width: 1)),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          // margin: EdgeInsets.all(100.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                topLeft: Radius.circular(14)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  AppColors.colorBlue,
                                  AppColors.colorGreen,
                                ]),
                            shape: BoxShape.rectangle,
                          ),
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "You're veeped",
                                  style: TextStyle(
                                      color: AppColors.colorYellow,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppDimensions.kFontSize30),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "You and Desirae have both liked each other",
                                  style: TextStyle(
                                      color: AppColors.fontColorWhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppDimensions.kFontSize14),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.asset(
                                      AppImages.imgLogoYellow,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(width: 120,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Kadin Dias',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: AppColors.fontColorWhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        AppDimensions.kFontSize18),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'CTO',
                                                style: TextStyle(
                                                    color: AppColors.fontColorWhite,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        AppDimensions.kFontSize12),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Wrap(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: AppColors.colorGray50,
                                                  size: 12,
                                                ),
                                                Text(
                                                  ' 7 miles',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .fontColorWhite,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: AppDimensions
                                                          .kFontSize12),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    CircleAvatar(
                                      radius: 40,
                                      child: Image.asset(AppImages.appLogo),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      child: Image.asset(AppImages.appLogo),
                                    ),
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SizedBox(width: 120,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Desirae Donin',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: AppColors.fontColorWhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        AppDimensions.kFontSize18),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Art Manager',
                                                style: TextStyle(
                                                    color: AppColors.fontColorWhite,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        AppDimensions.kFontSize12),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Wrap(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: AppColors.colorGray50,
                                                  size: 12,
                                                ),
                                                Text(
                                                  ' 7 miles',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .fontColorWhite,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: AppDimensions
                                                          .kFontSize12),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: AppColors.colorGray50,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    AppButton(
                                      buttonText: 'Send a Message',
                                      onTapButton: () {},
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Go Back to Discover',
                                      style: TextStyle(
                                          color: AppColors.colorGray400,
                                          fontWeight: FontWeight.w700,
                                          fontSize:AppDimensions.kFontSize14),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
