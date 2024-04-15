import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_colors.dart';
import 'package:veep_meep/utils/app_constants.dart';
import 'package:veep_meep/utils/app_utils.dart';

import '../../../../../utils/app_dimensions.dart';
import '../../../../domain/entities/veep_entity.dart';

class FavoriteCardUI extends StatelessWidget {
  final VeepEntity veepEntity;
  final bool isLiked;
  final VoidCallback onTap;

  FavoriteCardUI(
      {required this.veepEntity, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.colorGray50,
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(14),
                          topLeft: Radius.circular(14)),
                      child: SizedBox(
                        height: 155,
                        width: double.infinity,
                        child: Image.network(
                          veepEntity.images![0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLiked
                            ? Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: DateTime.now()
                                                .difference(
                                                    veepEntity.lastActive!)
                                                .inMinutes <
                                            2
                                        ? const Color(0xFF64DD17)
                                        : AppColors.colorPrimary,
                                    radius: 7,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        Text(
                          isLiked
                              ? AppUtils.getOnlineStatus(veepEntity.lastActive!)
                              : AppUtils.getLeftTime(veepEntity.timeExpire!),
                          style: TextStyle(
                              color: AppColors.titleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.kFontSize14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLiked
                ? const SizedBox.shrink()
                : Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue,
                      child: const Icon(
                        Icons.star,
                        color: AppColors.fontColorWhite,
                        size: 12,
                      ),
                    ))
          ],
        ));
  }
}
