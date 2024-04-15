import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/features/presentation/bloc/base_bloc.dart';
import 'package:veep_meep/features/presentation/bloc/base_event.dart';
import 'package:veep_meep/features/presentation/bloc/base_state.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../common/app_button.dart';
import '../base_view.dart';

class LoginView extends BaseView {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState<LoginView> {
  final bloc = injection<AuthBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  AppConstants.kIsBizAccount
                      ? AppImages.imgLoginYellowBackground
                      : AppImages.imgLoginWhiteBackground,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height / 2),
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    'By clicking "log in", you agree with our ',
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: 'Terms. ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context,
                                        Routes.kTermsAndConditionsView);
                                  },
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: 'Learn ',
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: 'how we process you data in our ',
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: 'Privacy Policy. ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context,
                                        Routes.kTermsAndConditionsView);
                                  },
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: 'and ',
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: 'Cookies Policy.',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context,
                                        Routes.kTermsAndConditionsView);
                                  },
                                style: TextStyle(
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AppButton(
                            buttonColor: AppColors.fontColorWhite,
                            prefixIcon: Image.asset(
                              AppImages.imgEmail,
                              width: 25,
                            ),
                            onTapButton: () {
                              Navigator.pushNamed(
                                  context, Routes.kEmailVerificationView);
                            },
                            buttonText: 'log in with private email',
                            textColor: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AppButton(
                          onTapButton: () {},
                          prefixIcon: Image.asset(
                            AppImages.imgGoogle,
                            width: 16,
                          ),
                          buttonColor: AppColors.fontColorWhite,
                          buttonText: 'log in with Google',
                          textColor: Colors.black45,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        "Trouble Logging in?",
                        style: TextStyle(
                            color: AppColors.fontColorWhite,
                            fontSize: AppDimensions.kFontSize14,
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 50.h),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Image.asset(
                      height: 175.h,
                      width: 175.w,
                      AppImages.appLogo,
                    ),
                  ),
                ),
              ),
            ],
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

class SecondContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 8, size.height - 75,
        (size.width / 4) + 50, size.height - 75);
    path.lineTo(((size.width * 3) / 4) - 50, size.height - 71);
    path.quadraticBezierTo(
        (size.width * 7) / 8, size.height - 75, size.width, size.height - 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class SecondContainerClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 12);
    path.quadraticBezierTo(size.width / 8, size.height - 75,
        (size.width / 4) + 50, size.height - 75);
    path.lineTo(((size.width * 3) / 4) - 50, size.height - 73);
    path.quadraticBezierTo(
        (size.width * 7) / 8, size.height - 75, size.width, size.height - 138);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
