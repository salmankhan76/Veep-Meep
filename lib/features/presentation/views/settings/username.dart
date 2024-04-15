import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/presentation/common/app_text_field.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/features/presentation/views/sign%20in/verify_otp_view.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/change_user_name_request.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';
import '../../common/app_button.dart';
import '../base_view.dart';

class UsernameView extends BaseView {
  final String userName;

  UsernameView({required this.userName});

  @override
  State<UsernameView> createState() => _UsernameState();
}

class _UsernameState extends BaseViewState<UsernameView> {
  var bloc = injection<SettingsBloc>();
  final userNameController = TextEditingController();

  @override
  void initState() {
    userNameController.text = widget.userName;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Username',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<SettingsBloc>(
        create: (_) => bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          listener: (_, state) {
            if (state is ChangeUserNameSuccessState) {
              AppConstants.profileData!.name = userNameController.text;
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    hint: 'veepmeep.com/@markfrakins',
                    controller: userNameController,
                    hintFontSize: AppDimensions.kFontSize15,
                    hintFontWeight: FontWeight.w400,
                    hintColor: AppColors.colorGray700,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      buttonText: 'Confirm',
                      buttonColor: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue,
                      onTapButton: () {
                        if (_isValid()) {
                          Navigator.pushNamed(context, Routes.kVerifyOtpView,
                              arguments: OtpArgs(email: appSharedData.getEmailAddress().toString(),isGenerated: true, otpUseCase: OTPUseCase.PROFILE_EDIT))
                              .then((value) {
                            if (value != null && value is bool && value) {
                              bloc.add(
                                ChangeUserNameEvent(
                                  changeUserNameRequest: ChangeUserNameRequest(
                                      userId: 1, userName: userNameController.text),
                                ),
                              );
                            }
                          });

                        }
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
    if (userNameController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Name cannot be empty');
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
