import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/utils/app_colors.dart';
import 'package:veep_meep/utils/app_constants.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../utils/enums.dart';

class GalleryComponent extends StatelessWidget {
  final VeepEntity veepEntity;
  final VoidCallback onTapped;
  final int veepStatus;

  GalleryComponent(
      {required this.veepEntity,
      required this.onTapped,
      required this.veepStatus});

  @override
  Widget build(BuildContext context) {
    var discoverComponentType = getDiscoverType(veepStatus);
    if (discoverComponentType == DiscoverComponentType.DEFAULT) {
      return InkWell(
        onTap: () {
          onTapped();
        },
        child: Column(
          children: [
            SizedBox(
              height: 186.h,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14)),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    veepEntity.profileImage != null
                        ? veepEntity.profileImage!
                        : veepEntity.images![0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                child: Container(
                  color: AppColors.colorGray50,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppConstants.kIsBizAccount
                            ? AppConstants.profileData!.serviceName ?? ''
                            : veepEntity.name ?? '',
                        style: TextStyle(
                            color: AppColors.colorGray800,
                            fontSize: AppDimensions.kFontSize14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.colorBlue,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Visibility(
                            visible: veepEntity.distance != null,
                            child: Text(
                              "${veepEntity.distance.toString()} miles",
                              style: TextStyle(
                                  color: AppColors.colorGray700,
                                  fontSize: AppDimensions.kFontSize12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (discoverComponentType == DiscoverComponentType.LIKED) {
      return InkWell(
        onTap: () {
          onTapped();
        },
        child: Column(
          children: [
            SizedBox(
              height: 186.h,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14)),
                child: Visibility(
                  visible: veepEntity.images != null &&
                      veepEntity.images![0] != null,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      veepEntity.images![0],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.colorGreen,
                          AppColors.colorBlue,
                        ]),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        veepEntity.name ?? '',
                        style: TextStyle(
                            color: AppColors.fontColorWhite,
                            fontSize: AppDimensions.kFontSize14,
                            fontWeight: FontWeight.w600),
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
                            size: 14,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Visibility(
                            visible: veepEntity.distance != null,
                            child: Text(
                              "${veepEntity.distance.toString()} miles",
                              style: TextStyle(
                                  color: AppColors.fontColorWhite,
                                  fontSize: AppDimensions.kFontSize12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (discoverComponentType == DiscoverComponentType.DISLIKED) {
      return Opacity(
        opacity: .4,
        child: InkWell(
          onTap: () {
            onTapped();
          },
          child: Column(
            children: [
              SizedBox(
                height: 186.h,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      topLeft: Radius.circular(14)),
                  child: Visibility(
                    visible: veepEntity.images != null &&
                        veepEntity.images![0] != null,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        veepEntity.images![0],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14)),
                  child: Container(
                    color: AppColors.colorGray50,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          veepEntity.name ?? '',
                          style: TextStyle(
                              color: AppColors.colorGray800,
                              fontSize: AppDimensions.kFontSize14,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.colorBlue,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "${veepEntity.distance.toString()} miles",
                              style: TextStyle(
                                  color: AppColors.colorGray700,
                                  fontSize: AppDimensions.kFontSize12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  DiscoverComponentType getDiscoverType(int veepStatus) {
    if (veepStatus == 0) {
      return DiscoverComponentType.DEFAULT;
    } else if (veepStatus == 1) {
      return DiscoverComponentType.LIKED;
    } else if (veepStatus == 2) {
      return DiscoverComponentType.DISLIKED;
    } else {
      return DiscoverComponentType.DEFAULT;
    }
  }
}
