import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/error/messages.dart';
import 'package:veep_meep/features/data/models/requests/signup_request.dart';
import 'package:veep_meep/features/presentation/views/sign%20in/verify_otp_view.dart';
import 'package:veep_meep/utils/app_constants.dart';
import 'package:veep_meep/utils/enums.dart';
import 'package:veep_meep/utils/navigation_routes.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../domain/entities/personal_data_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../../common/app_text_field.dart';
import '../base_view.dart';

class EmailViewArgs {
  final int packageId;
  final int accountType;

  EmailViewArgs({required this.packageId, required this.accountType});
}

class EmailView extends BaseView {
  EmailViewArgs args;

  EmailView({required this.args});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends BaseViewState<EmailView> {
  var bloc = injection<AuthBloc>();

  final _emailController = TextEditingController();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {
            if (state is SignupSuccessState) {
              appSharedData.setAppToken(state.signUpData!.token);
              appSharedData.setUserId(state.signUpData!.userId);
              appSharedData.setEmailAddress(state.email);

              AppConstants.kIsBizAccount = state.signUpData!.accountType == 2;

              if (state.signUpData!.status == 1) {
                Navigator.pushNamed(
                  context,
                  Routes.kVerifyOtpView,
                  arguments: OtpArgs(
                      email: state.email, otpUseCase: OTPUseCase.SIGNUP),
                ).then((value) {
                  if (value != null && value is bool && value) {
                    Navigator.pushNamed(
                        context,
                        AppConstants.kIsBizAccount
                            ? Routes.kOfferingView
                            : Routes.kPersonalDataSubmitView,
                        arguments: PersonalDataEntity());
                  }
                });
              } else if (state.signUpData!.status == 2) {
                Navigator.pushNamed(context, Routes.kAboutView);
              } else if (state.signUpData!.status == 3) {
                Navigator.pushNamed(context, Routes.kWebsitesView,
                    arguments: PersonalDataEntity());
              } else if (state.signUpData!.status == 4) {
                Navigator.pushNamed(context, Routes.kAddPhotosView);
              } else if (state.signUpData!.status == 5) {
                Navigator.pushNamed(context, Routes.kWebsitesView,
                    arguments: PersonalDataEntity());
              } else if (state.signUpData!.status == 6) {
                Navigator.pushNamed(context, Routes.kEmailVerificationView);
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 65.h,
                  ),
                  Image.asset(
                    AppImages.appSignup1,
                  ),
                  SizedBox(height: 15.h),
                  Text("What's your email?",
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize28,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 20.h),
                  Text("Don't lose access to your account, verify your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: 20.h),
                  AppTextField(
                    hint: "Enter your email",
                    textAlign: TextAlign.start,
                    controller: _emailController,
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppButton(
                        buttonText: 'Continue',
                        buttonColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        onTapButton: () {
                          if (_emailController.text.isEmpty) {
                            showAppDialog(
                                title: ErrorMessages.TITLE_ERROR,
                                message: 'Email address required');
                          } else {
                            Navigator.pushNamed(context, Routes.kWelcomeView)
                                .then((value) {
                              if (value != null && value is bool && value) {
                                bloc.add(
                                  SignupEvent(
                                      signupRequest: SignupRequest(
                                    packageId: widget.args.packageId,
                                    accountType: widget.args.accountType,
                                    emailAddress:
                                        _emailController.text.toLowerCase(),
                                  )),
                                );
                              }
                            });
                          }
                        },
                      ),
                      /* const SizedBox(
                        height: 10,
                      ),
                      Text("or",
                          style: TextStyle(
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.fontColorGray,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          AuthServices().signInWithGoogle(onSuccess: (user) {
                            Navigator.pushNamed(context, Routes.kWelcomeView)
                                .then((value) {
                              if (value != null && value is bool && value) {
                                bloc.add(
                                  SignupEvent(
                                      signupRequest: SignupRequest(
                                          packageId: widget.args.packageId,
                                          accountType: widget.args.accountType,
                                          emailAddress: user.email!)),
                                );
                              }
                            });
                          }, onError: (error) {
                            print(error);
                          });
                        },
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image.asset(
                                height: 25.h,
                                width: 25.w,
                                AppImages.icGoogle,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "sign in with Google",
                                style: TextStyle(
                                    color: AppColors.fontColorGray,
                                    fontSize: AppDimensions.kFontSize16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      ),*/
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.kTermsAndConditionsView);
                      },
                      child: Text('Terms of Use and Privacy Policy',
                          style: TextStyle(
                              color: AppConstants.kIsBizAccount
                                  ? AppColors.colorBlue
                                  : AppColors.fontColorGray,
                              fontSize: AppDimensions.kFontSize14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
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
