import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/views/unlock_options/widget/selection_option_ui.dart';
import 'package:veep_meep/utils/app_images.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/user_option_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/appbar.dart';
import '../base_view.dart';
import '../login/email_view.dart';
import 'widget/unselected_option_ui.dart';

class CustomerOptionsView extends BaseView {
  @override
  State<CustomerOptionsView> createState() => _CustomerOptionsViewState();
}

class _CustomerOptionsViewState extends BaseViewState<CustomerOptionsView> {
  var bloc = injection<AuthBloc>();
  final pageViewController = PageController(initialPage: 0);
  int _selectedPage = 0;

  final userOptions = [
    UserOptionEntity(
        optionName: 'Peach',
        amount: 2.48,
        hasAmount: true,
        numberOfContents: 1,
        isSelected: true,
        userOptionType: UserOptionType.PEACH),
    UserOptionEntity(
        optionName: 'Mango',
        amount: 3.48,
        hasAmount: true,
        numberOfContents: 7,
        userOptionType: UserOptionType.MANGO),
    UserOptionEntity(
        optionName: 'Try it out…',
        hasWeeks: true,
        numberOfWeeks: 8,
        userOptionType: UserOptionType.TRY),
  ];

  final titleList = [
    'veep meep | peach',
    'veep meep | mango',
    'veep meep | try it out…'
  ];

  final descriptions1 = [
    'Swipe around a Continent\nof your choice',
    'Swipe around the world!',
    'Swipe around the world for 8 weeks'
  ];

  final descriptions2 = [
    'Passport to all areas on 1 Continent',
    'Passport to anywhere!\n7 Continents',
    'Passport to anywhere!\n7 Continents for free'
  ];

  final imageList = [
    AppImages.imgPeach,
    AppImages.imgMango,
    AppImages.imgTryIt
  ];

  _getTitle() {
    return titleList[_selectedPage];
    /*switch (userOptions
        .firstWhere((element) => element.isSelected)
        .userOptionType) {
      case UserOptionType.PEACH:
        return titleList[0];
      case UserOptionType.MANGO:
        return titleList[1];
      case UserOptionType.TRY:
        return titleList[2];
    }*/
  }

  _getDescription1() {
    return descriptions1[_selectedPage];
    /*switch (userOptions
        .firstWhere((element) => element.isSelected)
        .userOptionType) {
      case UserOptionType.PEACH:
        return descriptions1[0];
      case UserOptionType.MANGO:
        return descriptions1[1];
      case UserOptionType.TRY:
        return descriptions1[2];
    }*/
  }

  _getDescription2() {
    return descriptions2[_selectedPage];
    /*switch (userOptions
        .firstWhere((element) => element.isSelected)
        .userOptionType) {
      case UserOptionType.PEACH:
        return descriptions2[0];
      case UserOptionType.MANGO:
        return descriptions2[1];
      case UserOptionType.TRY:
        return descriptions2[2];
    }*/
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: VeepMeepAppBar(
          title: _getTitle(),
          titleSize: AppDimensions.kFontSize18,
          goBackEnabled: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkResponse(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.colorBlue,
                ),
              ),
            )
          ]),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 170.h,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                      controller: pageViewController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedPage = index;
                          _changeOption(userOptions[_selectedPage]);
                        });
                      },
                      children: [
                        Image.asset(
                          imageList[0],
                        ),
                        Image.asset(
                          imageList[1],
                        ),
                        Image.asset(
                          imageList[2],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 90.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _getDescription1(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.colorGray800,
                              fontSize: AppDimensions.kFontSize16),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _getDescription2(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.colorGray800,
                              fontSize: AppDimensions.kFontSize14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SmoothPageIndicator(
                    controller: pageViewController,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: Color(0xFF0F76AF),
                      dotColor: Color(0xFFBDBDBD),
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                    onDotClicked: (index) {
                      pageViewController.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linearToEaseOut);
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 125.h,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray100,
                          border:
                              Border.all(color: AppColors.colorBlue, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: InkResponse(
                                onTap: () {
                                  _animateToPage(userOptions
                                      .where((element) =>
                                          element.isSelected == false)
                                      .toList()
                                      .first);
                                },
                                child: UnselectedOptionUI(
                                  userOptionEntity: userOptions
                                      .where((element) =>
                                          element.isSelected == false)
                                      .toList()
                                      .first,
                                ),
                              )),
                          Expanded(flex: 3, child: Container()),
                          Expanded(
                              flex: 2,
                              child: InkResponse(
                                onTap: () {
                                  _animateToPage(userOptions
                                      .where((element) =>
                                          element.isSelected == false)
                                      .toList()
                                      .last);
                                },
                                child: UnselectedOptionUI(
                                    userOptionEntity: userOptions
                                        .where((element) =>
                                            element.isSelected == false)
                                        .toList()
                                        .last),
                              )),
                        ],
                      ),
                    ),
                    SelectedOptionUI(
                      userOptionEntity: userOptions
                          .where((element) => element.isSelected == true)
                          .toList()
                          .first,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppButton(
                      buttonText: 'Continue',
                      onTapButton: () {
                        if (_getPackageId(userOptions
                                .indexWhere((element) => element.isSelected)) ==
                            3) {
                          AppConstants.kIsBizAccount = false;
                          Navigator.pushNamed(context, Routes.kEmailView,
                              arguments: EmailViewArgs(
                                  packageId: _getPackageId(
                                      userOptions.indexWhere(
                                          (element) => element.isSelected)),
                                  accountType: 1));
                        } else {
                          showAppDialog(
                              title: ErrorMessages.TITLE_ERROR,
                              message: 'Please select the free option for now');
                        }
                      }),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 25, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Recurring billing, cancel ',
                        style: TextStyle(
                            color: AppColors.fontColorGray,
                            fontSize: AppDimensions.kFontSize14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                            text: 'By tapping',
                            style: TextStyle(
                                color: AppColors.colorGray500,
                                fontSize: AppDimensions.kFontSize12),
                            children: [
                              TextSpan(
                                text: '“Continue”',
                                style: TextStyle(
                                    color: AppColors.colorGray800,
                                    fontSize: AppDimensions.kFontSize12),
                              ),
                              TextSpan(
                                text:
                                    ', your payment will be charged to your account, and your subscription will automatically renew for the same package length at the same price until you cancel in settings in the App store. By tapping ',
                                style: TextStyle(
                                    color: AppColors.colorGray500,
                                    fontSize: AppDimensions.kFontSize12),
                              ),
                              TextSpan(
                                text: '“Continue”',
                                style: TextStyle(
                                    color: AppColors.colorGray800,
                                    fontSize: AppDimensions.kFontSize12),
                              ),
                              TextSpan(
                                text: ', you agree to our ',
                                style: TextStyle(
                                    color: AppColors.colorGray500,
                                    fontSize: AppDimensions.kFontSize12),
                              ),
                              TextSpan(
                                text: 'Terms.',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context,
                                        Routes.kTermsAndConditionsView);
                                  },
                                style: TextStyle(
                                    color: AppColors.colorGray800,
                                    fontSize: AppDimensions.kFontSize12),
                              ),
                            ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _animateToPage(UserOptionEntity userOptionEntity) {
    if (userOptionEntity.optionName == 'Peach') {
      pageViewController.animateToPage(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut);
    } else if (userOptionEntity.optionName == 'Mango') {
      pageViewController.animateToPage(1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut);
    } else {
      pageViewController.animateToPage(2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut);
    }
  }

  _changeOption(UserOptionEntity userOptionEntity) {
    setState(() {
      userOptions.forEach((element) {
        element.isSelected = false;
      });
      userOptions
          .firstWhere((element) =>
              element.userOptionType == userOptionEntity.userOptionType)
          .isSelected = true;
    });
  }

  int _getPackageId(int selectedId) {
    if (selectedId == 0) {
      return 1;
    } else if (selectedId == 1) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
