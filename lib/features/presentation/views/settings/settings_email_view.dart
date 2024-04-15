import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/common/app_subtitle_text.dart';
import 'package:veep_meep/features/presentation/common/app_switch.dart';
import 'package:veep_meep/features/presentation/common/app_title_text.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../../utils/validator.dart';
import '../../../data/models/requests/change_user_email_request.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';
import '../../common/app_button.dart';
import '../../common/app_text_field.dart';
import '../base_view.dart';
import '../sign in/verify_otp_view.dart';

class SettingsEmailView extends BaseView {
  final String userEmail;

  SettingsEmailView({required this.userEmail});

  @override
  State<SettingsEmailView> createState() => _EmailViewState();
}

class _EmailViewState extends BaseViewState<SettingsEmailView> {
  var bloc = injection<SettingsBloc>();
  final emailController = TextEditingController();
  bool newMatchesValue = true;
  bool newMessagesValue = true;
  bool promotionsValue = true;

  @override
  void initState() {
    emailController.text = widget.userEmail;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Email',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<SettingsBloc>(
        create: (_) => bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          listener: (_, state) {
            if (state is ChangeUserEmailSuccessState) {
              appSharedData.setEmailAddress(emailController.text);
              Navigator.pop(context);
            } else if (state is EmailSettingSuccessState) {
              showAppDialog(
                  title: ErrorMessages.TITLE_SUCCESS, message: state.message);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSubText(
                    subtitle:
                        'Control the emails you want to get - all of them, just the important stuff or the bare minimum. You can always unsubscribe at the bottom of any email.',
                    fontSize: AppDimensions.kFontSize14,
                    fontWeight: FontWeight.w400,
                    color: AppConstants.kIsBizAccount
                        ? AppColors.colorBlue
                        : AppColors.colorGray600,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: appSharedData.getEmailAddress()??'',
                    borderColor: AppColors.colorBlue,
                    controller: emailController,
                    hintFontSize: AppDimensions.kFontSize15,
                    hintFontWeight: FontWeight.w400,
                    hintColor: AppColors.colorGray600,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppSubText(
                      fontSize: AppDimensions.kFontSize14,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorBlue
                          : AppColors.colorGray600,
                      subtitle:
                          'By verifying a new email, mark33@gmail.com will no longer be associated with your account.'),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      buttonText: 'Send Verification Email',
                      buttonColor: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue,
                      onTapButton: () {
                        if (_isValid()) {
                          Navigator.pushNamed(context, Routes.kVerifyOtpView,
                                  arguments: OtpArgs(
                                      email: appSharedData
                                          .getEmailAddress()
                                          .toString(),
                                      otpUseCase: OTPUseCase.EMAIL_EDIT,
                                      newEmail: emailController.text,
                                      isGenerated: true))
                              .then((value) {
                            if (value != null && value is bool && value) {
                              bloc.add(
                                ChangeUserEmailEvent(
                                  changeUserEmailRequest:
                                      ChangeUserEmailRequest(
                                          userId: appSharedData.getUserId()!,
                                          userEmail: emailController.text),
                                ),
                              );
                            }
                          });
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTitleText(
                        title: 'New matches',
                        fontsize: AppDimensions.kFontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorBlue
                            : AppColors.colorGray600,
                      ),
                      AppSwitch(
                        value: newMatchesValue,
                        onChanged: ((value) {
                          setState(() {
                            newMatchesValue = value;
                            bloc.add(
                              EmailSettingEvent(
                                  userId: 1,
                                  emailSettingId: 1,
                                  status: newMatchesValue ? 1 : 0),
                            );
                          });
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTitleText(
                        title: 'New messages',
                        fontsize: AppDimensions.kFontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorBlue
                            : AppColors.colorGray600,
                      ),
                      AppSwitch(
                          value: newMessagesValue,
                          onChanged: ((value) {
                            setState(() {
                              newMessagesValue = value;
                              bloc.add(
                                EmailSettingEvent(
                                    userId: 1,
                                    emailSettingId: 1,
                                    status: newMessagesValue ? 0 : 1),
                              );
                            });
                          })),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTitleText(
                        title: 'Promotions',
                        fontsize: AppDimensions.kFontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorBlue
                            : AppColors.colorGray600,
                      ),
                      AppSwitch(
                        value: promotionsValue,
                        onChanged: ((value) {
                          setState(() {
                            promotionsValue = value;
                            bloc.add(
                              EmailSettingEvent(
                                  userId: 1,
                                  emailSettingId: 1,
                                  status: promotionsValue ? 0 : 1),
                            );
                          });
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppSubText(
                      fontSize: AppDimensions.kFontSize14,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorBlue
                          : AppColors.colorGray600,
                      subtitle:
                          'I want to receive news, updates and offers from veep meep'),
                  //Spacer(),
                  const SizedBox(
                    height: 60,
                  ),
                  AppButton(
                      buttonColor: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue,
                      buttonText: 'Unsubscribe From All',
                      onTapButton: () {
                        bloc.add(EmailSettingEvent(
                            userId: 1, emailSettingId: 1, status: 0));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (emailController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Email cannot be empty');
      return false;
    } else if (!Validator.validateEmail(emailController.text)) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Invalid email address');
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
