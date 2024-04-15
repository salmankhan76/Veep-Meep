import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:veep_meep/error/messages.dart';
import 'package:veep_meep/features/data/models/requests/contact_us_request.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/utils/app_dimensions.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';
import '../../common/app_text_field.dart';
import '../base_view.dart';

class ContactUsView extends BaseView {
  @override
  State<ContactUsView> createState() => _LocationViewState();
}

class _LocationViewState extends BaseViewState<ContactUsView> {
  var bloc = injection<SettingsBloc>();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _infoController = TextEditingController();
  String country = '';
  String province = '';
  String city = '';

  Uint8List? file;
  String? fileExtension;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Contact Us',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<SettingsBloc>(
        create: (_) => bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          listener: (_, state) {
            if (state is ContactUsSuccessState) {
              showAppDialog(
                  title: ErrorMessages.TITLE_SUCCESS,
                  message: state.message,
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(AppConstants.UI_COMPONENT_PADDING),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    hint: 'Name*',
                    // borderColor: AppColors.colorBlue,
                    controller: _nameController,
                    hintFontSize: AppDimensions.kFontSize15,
                    hintFontWeight: FontWeight.w400,
                    hintColor: AppColors.colorGray600,
                  ),
                  AppTextField(
                    hint: 'Surname*',
                    // borderColor: AppColors.colorBlue,
                    controller: _surnameController,
                    hintFontSize: AppDimensions.kFontSize15,
                    hintFontWeight: FontWeight.w400,
                    hintColor: AppColors.colorGray600,
                  ),
                  AppTextField(
                    hint: 'Email*',
                    // borderColor: AppColors.colorBlue,
                    controller: _emailController,
                    hintFontSize: AppDimensions.kFontSize15,
                    hintFontWeight: FontWeight.w400,
                    hintColor: AppColors.colorGray600,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        border: Border.all(color: AppColors.colorGray700)),
                    child: SelectState(
                      style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorGray700),
                      // dropdownColor: AppColors.colorGray700,
                      onCountryChanged: (value) {
                        setState(() {
                          country = value.substring(4, value.length).trim();
                          province = '';
                          city = '';
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          if (value != "Choose State") {
                            province = value;
                            city = '';
                          }
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          if (value != "Choose City") {
                            city = value;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        if (file != null) {
                          setState(() {
                            file = null;
                            fileExtension = null;
                          });
                        } else {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(withData: true);
                          if (result != null) {
                            if (result.files.first.size / (1024 * 1024) > 10) {
                              showAppDialog(
                                  title: 'Error',
                                  message:
                                      'Attachment size too large. Please reduce file size and try again.');
                            } else {
                              setState(() {
                                file = result.files.first.bytes;
                                fileExtension = result.files.first.extension;
                              });
                            }
                          }
                        }
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SvgPicture.asset(
                            file != null
                                ? AppImages.icDeleteAttachment
                                : AppImages.icAttachment,
                            width: 18,
                            height: 18,
                            color: file != null
                                ? AppColors.colorGreen
                                : AppColors.colorGray700,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            file != null
                                ? 'Attached | Delete Attachment'
                                : "Attach | Max File Size 10MB",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400,
                              color: file != null
                                  ? AppColors.colorGreen
                                  : AppColors.colorGray700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppTextField(
                    hint: 'Added info',
                    // borderColor: AppColors.colorBlue,
                    controller: _infoController,
                    hintFontSize: AppDimensions.kFontSize15,
                    hintFontWeight: FontWeight.w400,
                    hintColor: AppColors.colorGray600,
                    textAlign: TextAlign.left,
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AppButton(
                    buttonText: 'Submit',
                    buttonColor: AppConstants.kIsBizAccount
                        ? AppColors.colorGreen
                        : AppColors.colorBlue,
                    onTapButton: () {
                      if (_isValid()) {
                        bloc.add(
                          ContactUsEvent(
                            contactUsRequest: ContactUsRequest(
                              userId: AppConstants.profileData!.veepId!,
                              name: _nameController.text,
                              surname: _surnameController.text,
                              email: _emailController.text,
                              country: country,
                              info: _infoController.text,
                              city: city,
                              state: province,
                              file: file,
                              extension: fileExtension,
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (_nameController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Name cannot be empty');
      return false;
    } else if (_surnameController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Surname cannot be empty');
      return false;
    } else if (_emailController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'Email address cannot be empty');
      return false;
    } else if (country.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: 'Country cannot be empty');
      return false;
    } else if (_infoController.text.isEmpty) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: 'Added info cannot be empty');
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
