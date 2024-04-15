import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:veep_meep/error/messages.dart';
import 'package:veep_meep/features/data/models/requests/change_mobile_request.dart';
import 'package:veep_meep/features/data/models/requests/logout_request.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_event.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/common/app_subtitle_text.dart';
import 'package:veep_meep/features/presentation/common/app_switch.dart';
import 'package:veep_meep/features/presentation/common/app_title_text.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_container.dart';
import '../../common/app_text_field.dart';
import '../base_view.dart';

class SettingsView extends BaseView {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseViewState<SettingsView> {
  var bloc = injection<AuthBloc>();
  bool shareMyfeedValue = true;
  bool recommendedSortValue = true;
  bool showMeinTopPicksValue = true;
  bool automatedDeclineMessageValue = true;
  bool activeStatusValue = true;
  bool showDistanceIn = true;
  final String userName = "Username";
  final String userEmail = "mark33@gmail.com";

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Settings',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {
            if (state is LogoutSuccessState) {
              appSharedData.clearAppToken();
              appSharedData.clearEmail();
              appSharedData.clearLogin();
              appSharedData.clearUserId();
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.kSplashView, (route) => false);
            } else if (state is ChangePhoneNumberSuccessState) {
              showAppDialog(
                  title: ErrorMessages.TITLE_SUCCESS,
                  message: 'Mobile number changed successfully',
                  onPositiveCallback: () {
                    setState(() {
                      AppConstants.profileData!.mobileNumber =
                          state.mobileNumber;
                    });
                  });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(
                          title: 'Personal Info',
                          fontsize: AppDimensions.kFontSize18,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppSubText(subtitle: 'Username'),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.kUsername,
                                      arguments: AppConstants.kIsBizAccount
                                          ? AppConstants
                                              .profileData!.serviceName
                                          : AppConstants.profileData!.name);
                                },
                                child: const Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppSubText(
                                subtitle:
                                    appSharedData.getEmailAddress().toString()),
                            InkWell(
                                onTap: (() {
                                  Navigator.pushNamed(
                                          context, Routes.kSettingsEmailView,
                                          arguments: appSharedData
                                              .getEmailAddress()
                                              .toString())
                                      .then((value) {
                                    setState(() {});
                                  });
                                }),
                                child: const Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      final _phoneNumberController = TextEditingController(
                          text: AppConstants.profileData!.mobileNumber != null
                              ? AppConstants.profileData!.mobileNumber!
                              : '');
                      showAppDialog(
                        title: 'Edit phone number',
                        dialogContentWidget: SizedBox(
                          // height: 200.h,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  maxLines: 1,
                                  controller: _phoneNumberController,
                                  labelText: 'Phone number',
                                  inputType: TextInputType.phone,
                                ),
                              ],
                            ),
                          ),
                        ),
                        positiveButtonText: "Save",
                        negativeButtonText: "Cancel",
                        onPositiveCallback: () {
                          try {
                            int pn = int.parse(_phoneNumberController.text);
                            bloc.add(
                              ChangePhoneNumberEvent(
                                changeMobileRequest: ChangeMobileRequest(
                                    userId: AppConstants.profileData!.veepId!,
                                    mobileNumber: _phoneNumberController.text),
                              ),
                            );
                          } catch (e) {
                            showAppDialog(
                                title: ErrorMessages.TITLE_ERROR,
                                message: 'Invalid phone number');
                          }
                        },
                      );
                    },
                    child: AppContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: AppSubText(subtitle: 'Phone Number')),
                          const SizedBox(
                            width: 5,
                          ),
                          AppSubText(
                            subtitle:
                                AppConstants.profileData!.mobileNumber != null
                                    ? AppConstants.profileData!.mobileNumber!
                                    : 'Not Listed',
                            color: AppColors.colorGray800,
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimensions.kFontSize15,
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(title: 'Location'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  AppSubText(subtitle: 'Current Location'),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppConstants.kIsBizAccount
                                  ? AppColors.colorGreen
                                  : AppColors.colorBlue,
                              child: const Icon(
                                Icons.done,
                                size: 16,
                                color: AppColors.fontColorWhite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.kLocationView);
                          },
                          child: AppSubText(
                            subtitle: 'Add a new location',
                            fontWeight: FontWeight.bold,
                            color: AppConstants.kIsBizAccount
                                ? AppColors.colorGreen
                                : AppColors.colorBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(title: 'Show Me'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppSubText(subtitle: 'Women'),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTitleText(title: 'Maximum distance'),
                            AppSubText(subtitle: '30mi')
                          ],
                        ),
                        Slider(
                          value: 30,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          onChanged: ((value) {}),
                          max: 100,
                          min: 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Row(
                      children: [
                        Expanded(child: AppTitleText(title: 'Share my feed')),
                        AppSwitch(
                            value: shareMyfeedValue,
                            backgroundColor: AppColors.fontColorWhite,
                            onChanged: ((value) {
                              setState(() {
                                shareMyfeedValue = value;
                              });
                            })),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: AppTitleText(title: 'Recommended sort')),
                        AppSwitch(
                          backgroundColor: AppColors.fontColorWhite,
                          value: recommendedSortValue,
                          onChanged: ((value) {
                            setState(() {
                              recommendedSortValue = value;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: AppTitleText(title: 'Show me in Top Picks')),
                        AppSwitch(
                          backgroundColor: AppColors.fontColorWhite,
                          value: showMeinTopPicksValue,
                          onChanged: ((value) {
                            setState(() {
                              showMeinTopPicksValue = value;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: AppTitleText(
                                title: 'Automated Decline Message')),
                        AppSwitch(
                            backgroundColor: AppColors.fontColorWhite,
                            value: automatedDeclineMessageValue,
                            onChanged: ((value) {
                              setState(() {
                                automatedDeclineMessageValue = value;
                              });
                            })),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: AppTitleText(title: 'Active status')),
                        AppSwitch(
                          value: activeStatusValue,
                          onChanged: ((value) {
                            setState(() {
                              activeStatusValue = value;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(title: 'Show Distance in'),
                        RadioListTile<bool>(
                          title: AppSubText(subtitle: 'Km'),
                          value: true,
                          groupValue: showDistanceIn,
                          dense: true,
                          activeColor: AppColors.colorBlue,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              showDistanceIn = value!;
                            });
                          }),
                        ),
                        RadioListTile<bool>(
                          title: AppSubText(subtitle: 'Mi'),
                          value: false,
                          groupValue: showDistanceIn,
                          dense: true,
                          activeColor: AppColors.colorBlue,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              showDistanceIn = value!;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTitleText(title: 'Payment account'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppSubText(subtitle: 'manage payment account'),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.kContactUsView);
                    },
                    child: AppContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTitleText(title: 'Contact Us'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppSubText(
                                subtitle: 'Help & Support',
                                color: AppConstants.kIsBizAccount
                                    ? AppColors.colorGreen
                                    : AppColors.colorBlue,
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (){
                        Share.share('veep meep is a community\nthat enables you to\ndiscover and connect\nlike-minded people,\nor get a date (not a fruit silly :-).\n\n\nyou can also find products,\nservices, and opportunities.\n\n\nsee who is available,\nsee what is available\n\n\ndon’t just chat or match…\nveep.\n\nhttps://veepmeep.com');
                    },
                    child: AppContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTitleText(title: 'Share veep meep'),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppContainer(
                      containerColor: Colors.black,
                      borderColor: Colors.black,
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'more matches ',
                                  style: TextStyle(
                                      fontSize: AppDimensions.kFontSize22,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.fontColorWhite),
                                ),
                                Text(
                                  AppConstants.kIsBizAccount
                                      ? '| get potato'
                                      : '| get mango',
                                  style: TextStyle(
                                      fontSize: AppDimensions.kFontSize22,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.fontColorWhite),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'across 6 other Continents',
                            style: TextStyle(
                                fontSize: AppDimensions.kFontSize16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.fontColorWhite),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      buttonText: 'Logout',
                      buttonColor: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue,
                      onTapButton: () {
                        return showCupertinoModalPopup(
                          context: context,
                          builder: ((context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                "Logout?",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              content: const Center(
                                  child: Text(
                                'Are you sure you want to log out?',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('Logout'),
                                  onPressed: () {
                                    bloc.add(
                                      LogoutEvent(
                                        logoutRequest: LogoutRequest(
                                            token:
                                                appSharedData.getAppToken()!),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                        );
                      })
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
