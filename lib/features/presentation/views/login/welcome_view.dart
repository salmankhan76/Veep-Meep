import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/features/presentation/views/login/widget/welcome_widget.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../base_view.dart';

class WelcomeView extends BaseView {
  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends BaseViewState<WelcomeView> {
  var bloc = injection<AuthBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: VeepMeepAppBar(
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
        goBackEnabled: false,
          actions:  [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkResponse(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.colorBlue,
                ),
              ),
            )
          ]
      ),
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Image.asset(
                    AppImages.appSignup2,
                  ),
                ),
                Image.asset(
                  width: 43.w,
                  height: 35.h,
                  AppImages.appVeepMeep2,
                ),
                Text("Welcome to veep meep",
                    style: TextStyle(
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorBlue
                            : AppColors.colorGray700,
                        fontSize: AppDimensions.kFontSize22,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                      "Please follow these community rules when using this app",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize18,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.kIsBizAccount
                              ? Colors.black
                              : AppColors.fontColorGray)),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WelcomeWidget(
                              text: 'Be yourself',
                              description:
                                  "Upload only your own photos, age and bio that's yours",
                            ),
                            WelcomeWidget(
                              text: 'Be kool',
                              description:
                                  'Keep kool and treat others with respect and dignity',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WelcomeWidget(
                              text: 'Be safe',
                              description:
                                  'Don’t give out personal info too quickly. Guage, analyse and date safely',
                            ),
                            WelcomeWidget(
                              text: 'Be active',
                              description:
                                  'Report others’ rude or bad behaviour actively so we can keep it safe',
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                        child: AppButton(
                          buttonText: 'I Understand',
                          buttonColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          onTapButton: () {
                            Navigator.pop(context, true);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.kTermsAndConditionsView);
                          },
                          child: Text(
                            "Terms of Use and Privacy Policy",
                            style: TextStyle(
                                fontSize: AppDimensions.kFontSize14,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.kIsBizAccount
                                    ? AppColors.colorBlue
                                    : AppColors.fontColorGray),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                //Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
