import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:veep_meep/features/domain/entities/personal_data_entity.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/common/app_text_field_type_2.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/personal_data_request.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class PersonalDataSubmitView extends BaseView {
  @override
  State<PersonalDataSubmitView> createState() => _PersonalDataSubmitViewState();
}

class _PersonalDataSubmitViewState
    extends BaseViewState<PersonalDataSubmitView> {
  var bloc = injection<AuthBloc>();

  PersonalDataEntity personalDataEntity = PersonalDataEntity();
  final _date = TextEditingController();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: 'Personal',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {
            if (state is PersonalDataSuccessState) {
              Navigator.pushNamed(context, Routes.kAboutView);
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
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.colorGray50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.colorGray400,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'My name & surname is',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.titleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.kFontSize22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppTextFieldType2(
                          hintColor: AppColors.colorBlue,
                          hint: 'Lorem ipsum',
                          onTextChanged: (value) {
                            personalDataEntity.name = value;
                          },
                          shouldRedirectToNextField: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'This is how it will appear in veep',
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
                          'My birthday is',
                          style: TextStyle(
                              color: AppColors.titleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.kFontSize22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkResponse(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(Duration(days: 365*16)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now().subtract(Duration(days: 365*16)));

                            if (pickedDate != null) {
                              setState(() {
                                _date.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                personalDataEntity.dob = _date.text;
                              });
                            }
                          },
                          child: //Text("${selectedDate.toLocal()}".split(' ')[0]),
                              AppTextFieldType2(
                            hintColor: AppColors.colorGray700,
                            hint: '22 - 10 - 2000',
                            isEnable: false,
                            controller: _date,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your age will we public',
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
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                              color: AppColors.titleColor,
                              fontSize: AppDimensions.kFontSize22,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioListTile(
                          title: Text(
                            "Female",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 1,
                          groupValue: personalDataEntity.genderId,
                          dense: true,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.genderId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Male",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 2,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.genderId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.genderId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Non-Binary",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 3,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.genderId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.genderId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Transwoman",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 4,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.genderId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.genderId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Transman",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 5,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.genderId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.genderId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "You decide",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 6,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.genderId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.genderId = value as int;
                            });
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
                          'Sexuality',
                          style: TextStyle(
                              color: AppColors.titleColor,
                              fontSize: AppDimensions.kFontSize22,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioListTile(
                          title: Text(
                            "Straight",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 1,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.sexualityId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.sexualityId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Gay",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 2,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.sexualityId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.sexualityId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Lesbian",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 3,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.sexualityId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.sexualityId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Bisexual",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 4,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.sexualityId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.sexualityId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Pansexual",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 5,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.sexualityId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.sexualityId = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "You decide",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 6,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.sexualityId,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.sexualityId = value as int;
                            });
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
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'My Vegan Scale',
                          style: TextStyle(
                              color: AppColors.titleColor,
                              fontSize: AppDimensions.kFontSize22,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioListTile(
                          title: Text(
                            "Starting out",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 1,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.veganScaleID,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.veganScaleID = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Intermediate",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 2,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.veganScaleID,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.veganScaleID = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "+2 years",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 3,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.veganScaleID,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.veganScaleID = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "Flexitarian",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 4,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.veganScaleID,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.veganScaleID = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "I've got more avocados than you",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 5,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.veganScaleID,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.veganScaleID = value as int;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            "I'm the vegan President ;-)",
                            style: TextStyle(
                                color: AppColors.colorGray700,
                                fontWeight: FontWeight.w400,
                                fontSize: AppDimensions.kFontSize16),
                          ),
                          value: 6,
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: personalDataEntity.veganScaleID,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (value) {
                            setState(() {
                              personalDataEntity.veganScaleID = value as int;
                            });
                          },
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
                          bloc.add(
                            PersonalDataEvent(
                              personalDataRequest: PersonalDataRequest(
                                userId: appSharedData.getUserId(),
                                name: personalDataEntity.name,
                                dob: personalDataEntity.dob,
                                gender: personalDataEntity.genderId.toString(),
                                sexuality:
                                    personalDataEntity.sexualityId.toString(),
                                veganScale:
                                    personalDataEntity.veganScaleID.toString(),
                              ),
                            ),
                          );
                        }
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (personalDataEntity.name == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Name cannot be empty");
      return false;
    } else if (personalDataEntity.dob == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Date of birth cannot be empty");
      return false;
    } else if (personalDataEntity.genderId == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Gender must be selected");
      return false;
    } else if (personalDataEntity.sexualityId == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Sexuality must be selected");
      return false;
    } else if (personalDataEntity.veganScaleID == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Vegan Scale must be selected");
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
