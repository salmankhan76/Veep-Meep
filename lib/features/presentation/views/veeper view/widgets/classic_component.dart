import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_dimensions.dart';
import '../../../../../utils/app_images.dart';
import '../../../../domain/entities/veep_entity.dart';

class ClassicComponent extends StatelessWidget {
  final pageController = PageController();
  final VeepEntity veepEntity;
  final VoidCallback onTapped;

  ClassicComponent({required this.veepEntity, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.colorGray50,
                width: 6.0,
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: veepEntity.images!.where((element) => element.isNotEmpty).length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        veepEntity.profileImage != null
                            ? veepEntity.profileImage!
                            : veepEntity.images![0],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: veepEntity.images!.where((element) => element.isNotEmpty).length,
                    effect: const WormEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      activeDotColor: AppColors.colorGray50,
                      strokeWidth: 1,
                      dotColor: AppColors.colorGray400,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 27,
              child: Image.asset(AppImages.imgCloseBtn),
            ),
            const SizedBox(
              width: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              children: [
                InkResponse(
                  onTap: () {
                    onTapped();
                  },
                  child: CircleAvatar(
                    radius: 43,
                    child: Image.asset(AppImages.imgVeepBtn),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: 27,
              child: Image.asset(AppImages.imgStartBtn),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Text(
              veepEntity.name!,
              style: TextStyle(
                  fontSize: AppDimensions.kFontSize24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorGray800),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  veepEntity.designation!,
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize16,
                      color: AppColors.colorGray700,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.location_on,
                  color: AppColors.colorBlue,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${veepEntity.distance} miles',
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize14,
                      color: AppColors.colorGray700,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              textAlign: TextAlign.center,
              veepEntity.bio!,
              style: TextStyle(
                  fontSize: AppDimensions.kFontSize16,
                  color: AppColors.colorGray700,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        )
      ],
    );
  }
}
