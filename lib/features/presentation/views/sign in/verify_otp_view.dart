import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:veep_meep/features/presentation/common/app_button_outline.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/features/presentation/views/sign%20in/widgets/num_pad.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/enums.dart';
import '../../../data/models/requests/otp_generate_request.dart';
import '../../../data/models/requests/otp_submit_request.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../bloc/otp/otp_event.dart';
import '../../bloc/otp/otp_state.dart';
import '../base_view.dart';

class OtpArgs {
  final String email;
  final String? newEmail;
  final bool? isGenerated;
  final OTPUseCase otpUseCase;

  OtpArgs(
      {required this.email,
      this.newEmail,
      this.isGenerated = false,
      required this.otpUseCase});
}

class VerifyOtpView extends BaseView {
  final OtpArgs args;

  VerifyOtpView({required this.args});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends BaseViewState<VerifyOtpView> {
  var bloc = injection<OtpBloc>();
  final TextEditingController _myController = TextEditingController();

  @override
  void initState() {
    if (widget.args.isGenerated!) {
      bloc.add(
        GetOtpDataEvent(
          otpGenerateRequest: OtpGenerateRequest(
              otpUseCase: widget.args.otpUseCase,
              userId: appSharedData.getUserId(),
              emailAddress: widget.args.newEmail ?? widget.args.email,
              isGenerated: 1),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: 'My code is',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<OtpBloc>(
        create: (_) => bloc,
        child: BlocListener<OtpBloc, BaseState<OtpState>>(
          listener: (_, state) {
            if (state is PushOtpDataSuccessState) {
            } else if (state is OtpSubmitDataSuccessState) {
              Navigator.pop(context, true);
            } else if (state is OtpSubmitDataFailedState) {
              showAppDialog(
                  title: ErrorMessages.TITLE_ERROR,
                  message: state.message,
                  onPositiveCallback: () {
                    _myController.clear();
                  });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pinput(
                    controller: _myController,
                    keyboardType: TextInputType.none,
                    onCompleted: (value) {
                      if (_isValid()) {
                        bloc.add(
                          SubmitOtpDataEvent(
                            otpSubmitRequest: OtpSubmitRequest(
                                emailAddress:
                                    widget.args.newEmail ?? widget.args.email,
                                otpCode: _myController.text,
                                userId: appSharedData.getUserId()),
                          ),
                        );
                      }
                    },
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(
                          fontSize: AppDimensions.kFontSize30,
                          color: AppColors.colorGray700,
                          fontWeight: FontWeight.w400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fieldBackgroundColor.withOpacity(.4),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Please enter the 4-digit code sent to you at ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: AppDimensions.kFontSize16,
                              color: AppConstants.kIsBizAccount
                                  ? AppColors.colorBlue
                                  : AppColors.colorGray600),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.args.newEmail ?? widget.args.email,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppDimensions.kFontSize16,
                                  color: AppConstants.kIsBizAccount
                                      ? AppColors.colorBlue
                                      : AppColors.colorGray800),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButtonOutline(
                    buttonText: 'Resend',
                    onTapButton: () {
                      bloc.add(
                        GetOtpDataEvent(
                          otpGenerateRequest: OtpGenerateRequest(
                              otpUseCase: widget.args.otpUseCase,
                              isGenerated: 0,
                              emailAddress:
                                  widget.args.newEmail ?? widget.args.email,
                              userId: appSharedData.getUserId()),
                        ),
                      );
                    },
                    width: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  NumPad(
                    buttonSize: 70,
                    buttonColor: AppColors.colorPrimary,
                    iconColor: AppColors.colorPrimary,
                    controller: _myController,
                    delete: () {
                      _myController.text = _myController.text
                          .substring(0, _myController.text.length - 1);
                    },
                    // do something with the input numbers
                    onSubmit: () {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (_myController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "OTP cannot be empty");
      return false;
    } else if (_myController.text.length < 4) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Incorrect OTP num');
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
