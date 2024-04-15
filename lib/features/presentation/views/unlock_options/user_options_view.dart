import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/utils/app_constants.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/app_images.dart';
import 'package:veep_meep/utils/navigation_routes.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class UserOptionsView extends BaseView {
  @override
  State<UserOptionsView> createState() => _UserOptionsViewState();
}

class _UserOptionsViewState extends BaseViewState<UserOptionsView> {
  var bloc = injection<AuthBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  AppColors.colorGreen,
                  AppColors.colorBlue,
                ],
                    stops: [
                  0.0,
                  0.9
                ])),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Center(
                    child: Image.asset(
                      AppImages.imgVeepMeep,
                      width: 182,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text.rich(
                    TextSpan(
                        text: 'veep meep is ',
                        style: TextStyle(
                            color: AppColors.fontColorWhite,
                            fontSize: AppDimensions.kFontSize16),
                        children: [
                          TextSpan(
                            text: 'a community\n',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'that enables you to\n',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                            text: 'discover and connect\n',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'with ',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                            text: 'like-minded people,\n',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'or ',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                            text: 'get a date ',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '(not a fruit silly :-).',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                              text:
                                  '\n\n\nyou can also find products,\nservices, and opportunities.\n\n\n',
                              style: TextStyle(
                                  color: AppColors.fontColorWhite,
                                  fontSize: AppDimensions.kFontSize16),
                              children: []),
                          TextSpan(
                            text: 'see ',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                            text: 'who is available,\n',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'see ',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                            text: 'what is available',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '\n\n\ndon’t just chat or match…\n',
                            style: TextStyle(
                                color: AppColors.fontColorWhite,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          TextSpan(
                            text: 'veep.',
                            style: TextStyle(
                              color: AppColors.fontColorWhite,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppConstants.kIsBizAccount = false;
                          Navigator.pushNamed(
                              context, Routes.kCustomerOptionsView);
                        },
                        child: Container(
                          width: 280.w,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppColors.fontColorWhite,
                          ),
                          child: Text(
                            'discover people | get a date',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.colorBlue,
                                fontSize: AppDimensions.kFontSize14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          AppConstants.kIsBizAccount = true;
                          Navigator.pushNamed(context, Routes.kBizOptionsView);
                        },
                        child: Container(
                          width: 280.w,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppColors.fontColorWhite,
                          ),
                          child: Text(
                            'add products or services',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.colorBlue,
                                fontSize: AppDimensions.kFontSize14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 35.h,),
                ],
              ),
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
