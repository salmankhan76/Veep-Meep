import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/data/models/requests/socials_data_request.dart';
import 'package:veep_meep/features/domain/entities/personal_data_entity.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_event.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/common/app_text_field_type_2.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class WebsitesView extends BaseView {
  PersonalDataEntity personalDataEntity;

  WebsitesView({required this.personalDataEntity});

  @override
  State<WebsitesView> createState() => _WebsiteViewState();
}

class _WebsiteViewState extends BaseViewState<WebsitesView> {
  var bloc = injection<AuthBloc>();
  final _webController = TextEditingController();
  final _fbController = TextEditingController();
  final _instaController = TextEditingController();
  final _lnINController = TextEditingController();
  final _snpController = TextEditingController();
  final _twtController = TextEditingController();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: 'Website & Socials',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is SocialsDataSuccessState) {
                Navigator.pushNamed(context, Routes.kAddPhotosView,);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 38.0,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    AppButton(buttonText: 'Skip',
                        width: 150,
                        buttonColor: AppConstants.kIsBizAccount?AppColors.colorGreen:AppColors.colorBlue,
                        onTapButton: (){
                          bloc.add(SocialsDataEvent(
                              socialsDataSubmitRequest:
                              SocialsDataSubmitRequest(
                                  userId: appSharedData.getUserId(),
                                  web: '',
                                  facebook: '',
                                  instagram: '',
                                  linkedin: '',
                                  snapchat: '',
                                  twitter: '')));
                    }),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorGray400,
                            width: 1,
                          )),
                      child: Column(
                        children: [
                          Text(
                            'Website',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.kFontSize22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _webController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            onTextChanged: (value) {
                              widget.personalDataEntity.web = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorGray400,
                            width: 1,
                          )),
                      child: Column(
                        children: [
                          Text(
                            'Facebook',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.kFontSize22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _fbController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            onTextChanged: (value) {
                              widget.personalDataEntity.fb = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorGray400,
                            width: 1,
                          )),
                      child: Column(
                        children: [
                          Text(
                            'Instagram',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.kFontSize22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _instaController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            onTextChanged: (value) {
                              widget.personalDataEntity.instagram = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorGray400,
                            width: 1,
                          )),
                      child: Column(
                        children: [
                          Text(
                            'Linkedin',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.kFontSize22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _lnINController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            onTextChanged: (value) {
                              widget.personalDataEntity.linkedIn = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorGray400,
                            width: 1,
                          )),
                      child: Column(
                        children: [
                          Text(
                            'Snapchat',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.kFontSize22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _snpController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            onTextChanged: (value) {
                              widget.personalDataEntity.snapChat = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorGray50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorGray400,
                            width: 1,
                          )),
                      child: Column(
                        children: [
                          Text(
                            'Twitter',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.kFontSize22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _twtController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            onTextChanged: (value) {
                              widget.personalDataEntity.twitter = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                        buttonText: 'Submit',
                        buttonColor: AppConstants.kIsBizAccount
                            ? AppColors.colorGreen
                            : AppColors.colorBlue,
                        onTapButton: () {
                          if (_isValid()) {
                            bloc.add(SocialsDataEvent(
                                socialsDataSubmitRequest:
                                    SocialsDataSubmitRequest(
                                      userId: appSharedData.getUserId(),
                                        web:
                                            widget.personalDataEntity.web ?? '',
                                        facebook:
                                            widget.personalDataEntity.fb ?? '',
                                        instagram: widget
                                                .personalDataEntity.instagram ??
                                            '',
                                        linkedin: widget
                                                .personalDataEntity.linkedIn ??
                                            '',
                                        snapchat: widget
                                                .personalDataEntity.snapChat ??
                                            '',
                                        twitter:
                                            widget.personalDataEntity.twitter ??
                                                '')));
                          }
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  bool _isValid() {
    /*if (widget.personalDataEntity.web == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'Website field cannot be empty');
      return false;
    } else if (widget.personalDataEntity.fb == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'Facebook field cannot be empty');
      return false;
    } else if (widget.personalDataEntity.instagram == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'Instagram field cannot be empty');
      return false;
    } else if (widget.personalDataEntity.linkedIn == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'LinkedIn field cannot be empty');
      return false;
    } else if (widget.personalDataEntity.snapChat == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'SnapChat field cannot be empty');
      return false;
    } else if (widget.personalDataEntity.twitter == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'Twitter field cannot be empty');
      return false;
    } else {
      return true;
    }*/

    return true;
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
