import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/error/messages.dart';
import 'package:veep_meep/features/data/models/requests/email_verification_request.dart';
import 'package:veep_meep/features/presentation/views/sign%20in/verify_otp_view.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../../utils/validator.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../../common/app_text_field_type_2.dart';
import '../../common/appbar.dart';
import '../base_view.dart';

class EmailVerificationView extends BaseView {
  EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends BaseViewState<EmailVerificationView> {
  var bloc = injection<AuthBloc>();

  final _emailController = TextEditingController();
  final _conformEmailController = TextEditingController();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: "My email is",
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {
            if (state is PushEmailVerificationSuccessState) {
              appSharedData.setEmailAddress(_emailController.text);
              appSharedData.setUserId(state.output!.userId);
              appSharedData.setAppToken(state.output!.token);
              AppConstants.kIsBizAccount = state.output!.accountType==2;

              Navigator.pushNamed(context, Routes.kVerifyOtpView,
                      arguments: OtpArgs(email: _emailController.text, otpUseCase: OTPUseCase.SIGNUP))
                  .then((value) {
                if (value != null && value is bool && value) {
                  appSharedData.setLoginAvailable(true);
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.kHomeView, (route) => false);
                }
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                AppTextFieldType2(
                  hint: "Email address",
                  hintColor: AppColors.colorGray400,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTextFieldType2(
                  hint: "Enter Email address again to conform",
                  hintColor: AppColors.colorGray400,
                  controller: _conformEmailController,
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  'When you tap "Continue" veep meep will email you a verifiction code..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorBlue
                          : AppColors.colorGray700,
                      fontSize: AppDimensions.kFontSize16,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 25.h,
                ),
                AppButton(
                  buttonText: 'Continue',
                  buttonColor: AppConstants.kIsBizAccount
                      ? AppColors.colorGreen
                      : AppColors.colorBlue,
                  onTapButton: () {
                    if (_isValid()) {
                      bloc.add(
                        GetEmailVerificationEvent(
                            emailVerificationRequest: EmailVerificationRequest(
                          emailAddress: _emailController.text.toLowerCase(),
                          loginType: 1,
                        )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (_emailController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Email can not be empty");
      return false;
    } else if (!Validator.validateEmail(_emailController.text)) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Invalid email address");
      return false;
    } else if (!Validator.validateEmail(_conformEmailController.text)) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Invalid email address");
      return false;
    } else if (_conformEmailController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Conform Email can not be empty");
      return false;
    } else if (_emailController.text.toLowerCase() !=
        _conformEmailController.text.toLowerCase()) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Email does not match');
      return false;
    } else {
      return true;
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
