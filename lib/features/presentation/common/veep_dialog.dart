import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class VeepDialog extends StatelessWidget {
  final VeepEntity veeper1, veeper2;
  final VoidCallback onSendMessage;
  final VoidCallback onCancel;

  VeepDialog(
      {required this.veeper1,
      required this.veeper2,
      required this.onCancel,
      required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
            alignment: FractionalOffset.center,
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                AppColors.colorGreen,
                                AppColors.colorBlue
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'You’re veeped',
                                style: TextStyle(
                                    color: AppColors.colorYellow,
                                    fontSize: AppDimensions.kFontSize30,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'You and Desirae have both liked each other',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.fontColorWhite,
                                    fontSize: AppDimensions.kFontSize14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                AppImages.imgLogoYellow,
                                width: 130,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MatchedVeepUI(
                                veepEntity: veeper1,
                                shouldAlignLeft: false,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MatchedVeepUI(
                                veepEntity: veeper2,
                                shouldAlignLeft: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            AppButton(
                                buttonText: 'Send a Message',
                                onTapButton: () {
                                  onSendMessage();
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                onCancel();
                              },
                              child: Text(
                                'Go Back to Discover',
                                style: TextStyle(
                                  color: AppColors.colorGray400,
                                  fontSize: AppDimensions.kFontSize14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class MatchedVeepUI extends StatelessWidget {
  final VeepEntity veepEntity;
  final bool shouldAlignLeft;

  MatchedVeepUI({required this.veepEntity, this.shouldAlignLeft = false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        shouldAlignLeft
            ? Wrap(
                children: [
                  CircleAvatar(
                    radius: 40,
                    foregroundImage: NetworkImage(veepEntity.profileImage!),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              )
            : const SizedBox.shrink(),
        Column(
          crossAxisAlignment: shouldAlignLeft
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              veepEntity.name ?? '',
              style: TextStyle(
                color: AppColors.fontColorWhite,
                fontSize: AppDimensions.kFontSize18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              veepEntity.designation ?? '',
              style: TextStyle(
                color: AppColors.fontColorWhite,
                fontSize: AppDimensions.kFontSize12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.fontColorWhite,
                  size: 15,
                ),
                Text(
                  '${veepEntity.distance} miles' ?? '',
                  style: TextStyle(
                    color: AppColors.fontColorWhite,
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        !shouldAlignLeft
            ? Wrap(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 40,
                    foregroundImage: NetworkImage(veepEntity.profileImage!),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
