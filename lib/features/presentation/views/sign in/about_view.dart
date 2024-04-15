import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veep_meep/features/data/models/requests/about_data_request.dart';
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

class AboutView extends BaseView {
  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends BaseViewState<AboutView> {
  var bloc = injection<AuthBloc>();
  PersonalDataEntity personalDataEntity = PersonalDataEntity();
  final _jobController = TextEditingController();
  final _hobbiesController = TextEditingController();
  final _aboutYouController = TextEditingController();
  final _neighbourhoodController = TextEditingController();

  final _focusNodeMotto = FocusNode();
  final _focusNodeHobby = FocusNode();
  final _focusNodeMore = FocusNode();
  final _focusNodeLocation = FocusNode();

  @override
  void dispose() {
    _focusNodeMotto.dispose();
    _focusNodeHobby.dispose();
    _focusNodeMore.dispose();
    _focusNodeLocation.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: 'About',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is AboutDataSuccessState){
                Navigator.pushNamed(context, Routes.kWebsitesView,
                    arguments: PersonalDataEntity());
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Motto | Job Title',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontSize: AppDimensions.kFontSize22,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _jobController,
                            hint: 'Lorem ipsum',
                            maxLength: 48,
                            hintColor: AppColors.colorBlue,
                            shouldRedirectToNextField: true,
                            onSubmit: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeHobby);
                            },
                            onTextChanged: (value) {
                              personalDataEntity.job = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'max. 48 char. displays in veep meep like',
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize14),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hobbies',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontSize: AppDimensions.kFontSize22,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            controller: _hobbiesController,
                            hintColor: AppColors.colorBlue,
                            hint: 'Lorem ipsum',
                            maxLength: 48,
                            focusNode: _focusNodeHobby,
                            shouldRedirectToNextField: true,
                            onSubmit: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeMore);
                            },
                            onTextChanged: (value) {
                              personalDataEntity.hobbies = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'max. 48 char. displays in veep meep like',
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize14),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'More about you...',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontSize: AppDimensions.kFontSize22,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Describe in 140 characters',
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize17),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFieldType2(
                            controller: _aboutYouController,
                            hintColor: AppColors.colorBlue,
                            maxLines: 4,
                            maxLength: 140,
                            hint: "I'm ....",
                            focusNode: _focusNodeMore,
                            shouldRedirectToNextField: true,
                            onSubmit: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeLocation);
                            },
                            onTextChanged: (value) {
                              personalDataEntity.about = value;
                            },
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                                color: AppColors.titleColor,
                                fontSize: AppDimensions.kFontSize22,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectState(
                            style: TextStyle(
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorGray700
                            ),
                            // dropdownColor: AppColors.colorGray700,
                            onCountryChanged: (value) {
                              setState(() {
                                personalDataEntity.country = value.substring(4, value.length).trim();
                                personalDataEntity.province = '';
                                personalDataEntity.city = '';

                              });
                            },
                            onStateChanged: (value) {
                              setState(() {
                                if(value!="Choose State"){
                                  personalDataEntity.province = value;
                                  personalDataEntity.city = '';
                                }

                              });
                            },
                            onCityChanged: (value) {
                              setState(() {
                                if(value!="Choose City") {
                                  personalDataEntity.city = value;
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Type in your neighbourhood's name",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize17),
                          ),
                          AppTextFieldType2(
                            controller: _neighbourhoodController,
                            hint: "Lorem ipsum",
                            shouldRedirectToNextField: false,
                            focusNode: _focusNodeMotto,
                            hintColor: AppColors.colorBlue,
                            onTextChanged: (value) {
                              personalDataEntity.location = value;
                            },
                            onSubmit: (value){
                              if(_isValid()){
                                bloc.add(AboutDataEvent(
                                    aboutDataSubmitRequest: AboutDataSubmitRequest(
                                        about: personalDataEntity.about ?? '',
                                        job: personalDataEntity.job ?? '',
                                        hobbies: personalDataEntity.hobbies ?? '',
                                        country: personalDataEntity.country ?? '',
                                        city: personalDataEntity.city ?? '',
                                        province: personalDataEntity.province ?? '',
                                        neighbourhood:
                                        personalDataEntity.location ?? '',
                                        userId: appSharedData.getUserId()
                                    )));
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
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
                            bloc.add(AboutDataEvent(
                                aboutDataSubmitRequest: AboutDataSubmitRequest(
                                    about: personalDataEntity.about ?? '',
                                    job: personalDataEntity.job ?? '',
                                    hobbies: personalDataEntity.hobbies ?? '',
                                    country: personalDataEntity.country ?? '',
                                    city: personalDataEntity.city ?? '',
                                    province: personalDataEntity.province ?? '',
                                    neighbourhood:
                                        personalDataEntity.location ?? '',
                                  userId: appSharedData.getUserId()
                                )));
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
    if (_jobController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Motto/Job cannot be empty');
      return false;
    } else if (_hobbiesController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Hobbies cannot be empty');
      return false;
    } else if (_aboutYouController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'About you field cannot be empty');
      return false;
    } else if (personalDataEntity.country == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Country must be selected');
      return false;
    } else if (_neighbourhoodController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Neighbourhood's name cannot be empty");
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
