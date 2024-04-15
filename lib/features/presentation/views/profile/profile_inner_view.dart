import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class ProfileInnerView extends BaseView {
  @override
  State<ProfileInnerView> createState() => _ProfileInnerViewState();
}

class _ProfileInnerViewState extends BaseViewState<ProfileInnerView> {
  var bloc = injection<AuthBloc>();
  List userDataList = [];
  final dotController = PageController();
  bool automatedDeclineMessageValue = true;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBorder,
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {},
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.colorBackground,
                child: AppConstants.profileData!.profileImage!.isNotEmpty
                    ? Image.network(
                        AppConstants.profileData!.profileImage!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AppImages.imgTest1,
                        fit: BoxFit.cover,
                      ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.colorBackground,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.kMyPhotosView);
                        },
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.colorBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 20, top: 08),
                    width: double.infinity,
                    height: 240,
                    decoration: const BoxDecoration(
                        color: AppColors.colorBackground,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36))),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                AppConstants.kIsBizAccount
                                    ? AppConstants.profileData!.serviceName ?? ''
                                    : '${AppConstants.profileData!.name ?? ''}, ${AppConstants.profileData!.age ?? ''}',
                                style: TextStyle(
                                    color: AppColors.fontColorDark,
                                    fontSize: AppDimensions.kFontSize22,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppConstants.kIsBizAccount
                                        ? '${AppConstants
                                        .profileData!.city!=null?'${AppConstants
                                        .profileData!.city}, ':''}${AppConstants
                                        .profileData!.country}'
                                        : AppConstants
                                            .profileData!.designation!,
                                    style: TextStyle(
                                      fontSize: AppDimensions.kFontSize16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorGray700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                  ),
                                  Text(
                                    '${AppConstants.profileData!.distance} miles' ??
                                        '10 miles',
                                    style: TextStyle(
                                      color: AppColors.colorGray700,
                                      fontSize: AppDimensions.kFontSize14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppConstants.kIsBizAccount
                                    ? AppConstants.profileData!.slogan??''
                                    : AppConstants.profileData!.hobbies!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.colorGray700,
                                  fontSize: AppDimensions.kFontSize16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Visibility(
                                    visible: !AppConstants.kIsBizAccount,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: 'Gender: ',
                                          style: TextStyle(
                                            color: AppColors.colorGray700,
                                            fontSize: AppDimensions.kFontSize14,
                                            fontWeight: FontWeight.w400,),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: getGenderName(AppConstants
                                                  .profileData!.gender!),
                                              style: TextStyle(
                                                  fontSize: AppDimensions.kFontSize14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppConstants.kIsBizAccount
                                                      ? AppColors.colorGreen
                                                      : AppColors.colorBlue),
                                            )
                                          ]),
                                    ),
                                  ),
                                  _getSocialText(),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 06,
                          right: 06,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 08, horizontal: 08),
                            decoration: BoxDecoration(
                                color: AppColors.colorGray50,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                        context,
                                        AppConstants.kIsBizAccount
                                            ? Routes.kEditOffering
                                            : Routes.kProfileEditView)
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: AppConstants.kIsBizAccount
                                    ? AppColors.colorGreen
                                    : AppColors.colorBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSocialText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (AppConstants.profileData!.web != null &&
            AppConstants.profileData!.web!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Website: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.web!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (AppConstants.profileData!.fb != null &&
            AppConstants.profileData!.fb!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Facebook: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.fb!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (AppConstants.profileData!.instagram != null &&
            AppConstants.profileData!.instagram!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Instagram: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.instagram!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (AppConstants.profileData!.linkedin != null &&
            AppConstants.profileData!.linkedin!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'LinkedIn: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.linkedin!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (AppConstants.profileData!.snapchat != null &&
            AppConstants.profileData!.snapchat!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Snapchat: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.snapchat!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
        if (AppConstants.profileData!.twitter != null &&
            AppConstants.profileData!.twitter!.isNotEmpty)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Twitter: ',
                style: TextStyle(
                  color: AppColors.colorGray700,
                  fontSize: AppDimensions.kFontSize14,
                  fontWeight: FontWeight.w400,),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.twitter!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue),
                  )
                ]),
          ),
      ],
    );
  }

  String getGenderName(String genderValue) {
    switch (genderValue) {
      case '1':
        return 'Female';
      case '2':
        return 'Male';
      case '3':
        return 'Non-Binary';
      case '4':
        return 'Transwoman';
      case '5':
        return 'Transman';
      case '6':
        return 'You Decide';
      default:
        return '';
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
