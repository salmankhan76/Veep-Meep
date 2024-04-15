import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/utils/app_constants.dart';
import '../../../core/configurations/app_config.dart';
import '../../../core/service/dependency_injection.dart';
import '../../../error/messages.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../data/datasources/shared_preference.dart';
import '../bloc/base_bloc.dart';
import '../bloc/base_state.dart';
import '../bloc/base_event.dart';
import '../common/app_dialog.dart';
import '../common/file_upload_progress_dialog.dart';
import '../common/veep_dialog.dart';

abstract class BaseView extends StatefulWidget {
  BaseView({Key? key}) : super(key: key);
}

abstract class BaseViewState<Page extends BaseView> extends State<Page> {
  final appSharedData = injection<AppSharedData>();

  Base<BaseEvent, BaseState<dynamic>> getBloc();

  Widget buildView(BuildContext context);

  bool _isProgressShow = false;
  bool _isLoadingShow = false;

  @override
  void initState() {
    super.initState();
    
    if (AppConfig.deviceOS == DeviceOS.ANDROID) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Base>(
      create: (_) => getBloc(),
      child: BlocListener<Base, BaseState>(
        listener: (context, state) {
          if (state is APILoadingState) {
            showProgressBar(shouldShowDialog: state.shouldShowDialog);
          } else {
            hideProgressBar();
            if (state is APIFailureState) {
              showAppDialog(
                  title: ErrorMessages.TITLE_ERROR,
                  message: state.errorResponseModel.responseError,
                  onPositiveCallback: () {});
            }
          }
        },
        child: Container(
            margin: EdgeInsets.only(bottom: UniversalPlatform.isIOS ? 5 : 0),
            child: buildView(context)),
      ),
    );
  }

  void showCustomDialog(
      {required Widget body, double? width, VoidCallback? onTap}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                alignment: FractionalOffset.center,
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width:
                            width ?? MediaQuery.of(context).size.width * 3 / 4,
                        decoration: const BoxDecoration(
                          color: AppColors.fontColorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // gradient: AppConstants.COMMON_UI_GRADIENT,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              body,
                              const SizedBox(height: 20),
                              AppButton(
                                onTapButton: () {
                                  if (onTap != null) onTap!();
                                  Navigator.of(context).pop();
                                },
                                buttonText: 'OK',
                                buttonColor: AppConstants.kIsBizAccount
                                    ? AppColors.colorGreen
                                    : AppColors.colorBlue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox.shrink();
      },
    );
  }

  showVeepDialog(
      {required VeepEntity veeper1,
      required VeepEntity veeper2,
      VoidCallback? onSendMessage}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: VeepDialog(
                  veeper1: veeper1,
                  veeper2: veeper2,
                  onSendMessage: () {
                    if (onSendMessage != null) {
                      onSendMessage();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  }),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SizedBox.shrink();
        });
  }

  void showAppDialog(
      {required String title,
      String? message,
      Color? messageColor,
      String? subDescription,
      Color? subDescriptionColor,
      AlertType alertType = AlertType.SUCCESS,
      String? positiveButtonText,
      String? negativeButtonText,
      VoidCallback? onPositiveCallback,
      VoidCallback? onNegativeCallback,
      Widget? dialogContentWidget,
      bool shouldDismiss = false,
      bool? shouldEnableClose,
      bool isSessionTimeout = false}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: shouldDismiss,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                alertType: alertType,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SizedBox.shrink();
        });
  }

  showProgressBar({bool shouldShowDialog = false}) {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: shouldShowDialog
                        ? FileUploadProgressDialog()
                        : Container(
                            alignment: FractionalOffset.center,
                            child: Wrap(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  child: const SpinKitFadingFour(
                                    color: AppColors.colorPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const SizedBox.shrink();
          });
    }
  }

  hideProgressBar() {
    if (_isProgressShow) {
      Navigator.pop(context);
      _isProgressShow = false;
    }
  }

  hideLoading() {
    if (_isLoadingShow) {
      Navigator.pop(context);
      _isLoadingShow = false;
    }
  }
}
