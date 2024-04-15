import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:veep_meep/features/presentation/views/veeper%20view/widgets/gallery_component.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/veep_entity.dart';

class DiscoverGalleryView extends StatelessWidget {
  final VoidCallback onRefresh;
  final List<VeepEntity> veepList;

  DiscoverGalleryView({required this.onRefresh, required this.veepList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkResponse(
              onTap: () {
                onRefresh();
              },
              child: SvgPicture.asset(
                AppImages.icRefresh,
                color: AppColors.colorGray800,
              ),
            ),
             Text(
              'Discover',
              style: TextStyle(
                  color: AppColors.colorGray800,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions.kFontSize24),
            ),
            InkResponse(
              onTap: (){
                Navigator.pushNamed(context, Routes.kFiltersView);
              },
              child: SvgPicture.asset(
                AppImages.icFilter,
                color: AppColors.colorGray800,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .6,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              shrinkWrap: true,
              itemCount: veepList.length,
              itemBuilder: (BuildContext context, int index) {
                return GalleryComponent(
                  veepEntity: veepList[index],
                  onTapped: () {
                    Navigator.pushNamed(context, Routes.kDiscoverProfileView,
                        arguments: veepList[index]);
                  }, veepStatus: veepList[index].veepStatus??1,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
