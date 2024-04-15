import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/views/intro/widget/intro_clip_path.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/app_images.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/navigation_routes.dart';

class IntroView extends StatefulWidget {
  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final pageViewController = PageController(initialPage: 0);
  int _selectedPage = 0;
  final imageList = [
    AppImages.imgIntro1,
    AppImages.imgIntro2,
    AppImages.imgIntro3
  ];
  final titleList = [
    'discover people,\nget a date',
    'find products & services',
    'chat | match | veep'
  ];
  final descriptionList = [
    'Find like minded people to\nconnect with',
    "See what’s available,\nget what you need.",
    'Don’t just chat or match…\nveep.'
  ];

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: IntroCurveClipper(),
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 2) + 10,
                      color: AppColors.colorYellow,
                    ),
                  ),
                  ClipPath(
                    clipper: IntroCurveClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColors.colorGreen,
                          AppColors.colorBlue,
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 65.h,
                  child: Text(
                    titleList[_selectedPage],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.fontColorWhite,
                        fontSize: AppDimensions.kFontSize24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    height:
                        (MediaQuery.of(context).size.height * (5 / 9)) - 30.h,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                      controller: pageViewController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedPage = index;
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
                  const SizedBox(
                    height: 20,
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
                      })
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                descriptionList[_selectedPage],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppDimensions.kFontSize20,
                    color: AppColors.colorGray700),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                child: AppButton(
                    buttonColor: AppColors.colorGreen,
                    buttonText: 'Next',
                    onTapButton: () {
                      if (_selectedPage != 2) {
                        pageViewController.animateToPage(_selectedPage + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linearToEaseOut);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, Routes.kUserOptionsView);
                      }
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
