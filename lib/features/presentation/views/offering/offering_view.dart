import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veep_meep/features/domain/entities/personal_data_entity.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/offering_request.dart';
import '../../../domain/entities/peoduct_service_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../../common/app_container.dart';
import '../../common/app_subtitle_text.dart';
import '../../common/app_text_field_type_2.dart';
import '../../common/appbar.dart';
import '../base_view.dart';

class OfferingView extends BaseView {
  final PersonalDataEntity personalDataEntity;

  OfferingView({required this.personalDataEntity});

  @override
  State<OfferingView> createState() => _OfferingViewState();
}

class _OfferingViewState extends BaseViewState<OfferingView> {
  var bloc = injection<AuthBloc>();
  ProductServiceEntity productServiceEntity = ProductServiceEntity();
  final _description1 = TextEditingController();
  final _description2 = TextEditingController();
  final _description3 = TextEditingController();
  final _description4 = TextEditingController();

  Uint8List? file;
  String? fileExtension;

  @override
  void initState() {
    productServiceEntity = ProductServiceEntity();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorWhite,
      appBar: VeepMeepAppBar(
        title: 'Offering',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.fontColorWhite,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is SubmitOfferingSuccessState) {
                Navigator.pushNamed(
                  context,
                  Routes.kWebsitesView,
                  arguments: widget.personalDataEntity,
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: AppContainer(
                      borderColor: Colors.teal,
                      child: Column(
                        children: [
                          Text("My product/service name is",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize22,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            hint: "Lorem ipsum",
                            maxLength: 28,
                            onTextChanged: (value) {
                              productServiceEntity.productName = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("max. 28 characters. displays in veep meep like",
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.colorGray700))
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: AppContainer(
                      child: Column(
                        children: [
                          Text("Slogan",
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize22,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            hint: "Lorem ipsum",
                            maxLength: 28,
                            onTextChanged: (value) {
                              productServiceEntity.slogan = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("max. 28 characters. displays in veep meep like",
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.colorGray700))
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: AppContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Product/Service Description",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.kFontSize22,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Describe in 140 characters",
                              style: TextStyle(
                                  color: AppColors.colorGray700,
                                  fontSize: AppDimensions.kFontSize17,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldType2(
                            hint: "",
                            controller: _description1,
                            onTextChanged: (value) {
                              _getProductDescription();
                            },
                          ),
                          AppTextFieldType2(
                            hint: "",
                            controller: _description2,
                            onTextChanged: (value) {
                              _getProductDescription();
                            },
                          ),
                          AppTextFieldType2(
                            hint: "",
                            controller: _description3,
                            onTextChanged: (value) {
                              _getProductDescription();
                            },
                          ),
                          AppTextFieldType2(
                            hint: "",
                            controller: _description4,
                            onTextChanged: (value) {
                              _getProductDescription();
                            },
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text('Product/Service Type',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.colorGray900,
                                    fontSize: AppDimensions.kFontSize22,
                                    fontWeight: FontWeight.w600))),
                        const SizedBox(
                          height: 20,
                        ),
                        RadioListTile(
                          title: AppSubText(
                            subtitle: 'Consulting',
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorGray700,
                          ),
                          value: "1",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Event Spaces & Conferencing',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorGray700),
                          value: "2",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Fashion',
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorGray700),
                          value: "3",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Food & Beverage',
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray700,
                              fontWeight: FontWeight.w400),
                          value: "4",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Health & Medical',
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray700,
                              fontWeight: FontWeight.w400),
                          value: "5",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Leisure & Travel',
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray700,
                              fontWeight: FontWeight.w400),
                          value: "6",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Sport',
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray700,
                              fontWeight: FontWeight.w400),
                          value: "7",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Sustainable & Eco Environment',
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray700,
                              fontWeight: FontWeight.w400),
                          value: "8",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Wellbeing & Fitness',
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray700,
                              fontWeight: FontWeight.w400),
                          value: "9",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Multiple Offerings',
                              color: AppColors.colorGray700,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "10",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                        RadioListTile(
                          title: AppSubText(
                              subtitle: 'Other',
                              color: AppColors.colorGray700,
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400),
                          value: "11",
                          activeColor: AppConstants.kIsBizAccount
                              ? AppColors.colorGreen
                              : AppColors.colorBlue,
                          groupValue: productServiceEntity.productType,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: ((value) {
                            setState(() {
                              productServiceEntity.productType =
                                  value.toString();
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: AppContainer(
                    child: Column(children: [
                      Center(
                          child: Text("Location",
                              style: TextStyle(
                                  color: AppColors.colorGray900,
                                  fontSize: AppDimensions.kFontSize22,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(height: 20),
                      SelectState(
                        style: TextStyle(
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorGray700),
                        // dropdownColor: AppColors.colorGray700,
                        onCountryChanged: (value) {
                          setState(() {
                            productServiceEntity.country = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            productServiceEntity.province = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            productServiceEntity.city = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      Text("Type in your neighbourhood's name",
                          style: TextStyle(
                              fontSize: AppDimensions.kFontSize16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorGray700)),
                      AppTextFieldType2(
                        hint: "",
                        onTextChanged: (value) {
                          productServiceEntity.nabourhoodName = value;
                        },
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                  child: AppContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Overview PDF (Max 5MB)",
                            style: TextStyle(
                                color: AppColors.colorGray900,
                                fontSize: AppDimensions.kFontSize22,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Upload an overview pdf of your product or service offering.You may"
                              "include your rates.",
                          style: TextStyle(
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorGray700,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (file != null) {
                              setState(() {
                                file = null;
                                fileExtension = null;
                              });
                            } else {
                              FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'],
                                  withData: true
                              );
                              if (result != null) {
                                setState(() {
                                  file = result.files.first.bytes;
                                  fileExtension = result.files.first.extension;
                                });
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
                                file != null ? 'Attached' : "Upload",
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 20, bottom: 20),
                  child: AppButton(
                    buttonText: 'Submit',
                    buttonColor: AppColors.colorGreen,
                    onTapButton: () {
                      if (_isValid()) {
                        bloc.add(
                          SubmitOfferingEvent(
                              offeringRequest: OfferingRequest(
                                  userId: appSharedData.getUserId()!,
                                  city: productServiceEntity.city ?? '',
                                  country: productServiceEntity.country ?? '',
                                  extension: fileExtension,
                                  file: file,
                                  neighbourhood:
                                  productServiceEntity.nabourhoodName ?? '',
                                  province: productServiceEntity.province ?? '',
                                  serviceDescription:
                                  productServiceEntity.productDescription ??
                                      '',
                                  serviceName:
                                  productServiceEntity.productName ?? '',
                                  serviceType:
                                  int.parse(productServiceEntity.productType!) ,
                                  slogan: productServiceEntity.slogan ?? '')),
                        );
                      }
                    },
                  ),
                )
              ]),
            )),
      ),
    );
  }

  _getProductDescription() {
    productServiceEntity.productDescription =
        _description1.text + _description2.text + _description3.text +
            _description4.text;
  }

  bool _isValid() {
    if (productServiceEntity.productName == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "My product/service name cannot be empty");
      return false;
    } else if (productServiceEntity.slogan == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Slogan cannot be empty");
      return false;
    } else if (productServiceEntity.productDescription == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Product/service description cannot be empty");
      return false;
    } else if (productServiceEntity.productType == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Product/Service type must be selected");
      return false;
    } else if (productServiceEntity.country == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Country must be selected");
      return false;
    } else if (productServiceEntity.nabourhoodName == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Neighbourhood's name cannot be empty");
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
