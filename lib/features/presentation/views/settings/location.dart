import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/common/app_subtitle_text.dart';
import 'package:veep_meep/features/presentation/common/app_title_text.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../domain/entities/location_data_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';
import '../base_view.dart';

class LocationView extends BaseView {
  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends BaseViewState<LocationView> {
  var bloc = injection<SettingsBloc>();
  final List<LocationDataEntity> locationData = [];

  @override
  void initState() {
    bloc.add(LocationEvent(userId: 1));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Location',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<SettingsBloc>(
        create: (_) => bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
            listener: (_, state) {
              if (state is LocationSuccessState) {
                setState(() {
                  locationData.clear();
                  locationData.addAll(state.output.map(
                      (e) => LocationDataEntity(state: e.state, town: e.town),),);
                });
              }
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorYellow
                            : AppColors.colorBackground,
                        border: Border.all(
                            color: AppConstants.kIsBizAccount
                                ? AppColors.colorGreen
                                : AppColors.colorGray700,
                            width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(24),),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppConstants.kIsBizAccount
                                  ? AppColors.colorGreen
                                  : AppColors.colorGray700,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize14,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.kIsBizAccount
                                      ? AppColors.colorGreen
                                      : AppColors.colorGray700),
                            )
                          ],
                        ),
                        Icon(
                          Icons.gps_fixed_rounded,
                          color: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorGray700,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: locationData.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 08),
                        padding: const EdgeInsets.symmetric(horizontal: 34),
                        height: 44,
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.colorBlue,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTitleText(
                                  title: locationData[index].state,
                                  fontsize: AppDimensions.kFontSize18,
                                ),
                                AppSubText(
                                  subtitle: locationData[index].town,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.colorGray600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorGray800
                          : AppColors.colorBlue,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
