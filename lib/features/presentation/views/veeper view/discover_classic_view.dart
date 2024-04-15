import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:veep_meep/features/presentation/views/veeper%20view/widgets/classic_component.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/veep_entity.dart';

class DiscoverClassicView extends StatelessWidget {
  final VoidCallback onRefresh;
  final List<VeepEntity> veepList;

  DiscoverClassicView({required this.onRefresh, required this.veepList});

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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: veepList.length,
            itemBuilder: (BuildContext context, int index) {
              return ClassicComponent(
                veepEntity: veepList[index],
                onTapped: () {
                  //TODO: Uncomment
                  Navigator.pushNamed(context, Routes.kDiscoverProfileView,
                      arguments: veepList[index]);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
