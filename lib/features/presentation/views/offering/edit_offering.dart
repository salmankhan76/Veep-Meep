import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veep_meep/features/data/models/requests/biz_edit_request.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_event.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/profile_select_request.dart';
import '../../../data/models/requests/user_image_change_request.dart';
import '../../../data/models/responses/veep_data_response.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../../common/app_data_compo.dart';
import '../../common/app_subtitle_text.dart';
import '../../common/app_switch.dart';
import '../../common/app_text_field.dart';
import '../../common/appbar.dart';
import '../base_view.dart';
import '../sign in/verify_otp_view.dart';
import 'package:path/path.dart' as path;

class EditOffering extends BaseView {
  @override
  State<EditOffering> createState() => _EditOfferingState();
}

class _EditOfferingState extends BaseViewState<EditOffering> {
  var bloc = injection<AuthBloc>();
  String? extension;
  Uint8List? profileImage;
  bool automatedAwayMassage = true;
  Uint8List? file;
  String? fileExtension;
  final VeepData veepData = VeepData(
    accountType: AppConstants.profileData!.accountType,
    veepId: AppConstants.profileData!.veepId ?? 0,
    city: AppConstants.profileData!.city ?? '',
    country: AppConstants.profileData!.country ?? '',
    province: AppConstants.profileData!.province ?? '',
    serviceType: AppConstants.profileData!.serviceType ?? '3',
    description: AppConstants.profileData!.description ?? '',
    serviceName: AppConstants.profileData!.serviceName ?? '',
    pdf: AppConstants.profileData!.pdf ?? '',
    slogan: AppConstants.profileData!.slogan ?? '',
    web: AppConstants.profileData!.web ?? '',
    fb: AppConstants.profileData!.fb ?? '',
    instagram: AppConstants.profileData!.instagram ?? '',
    snapchat: AppConstants.profileData!.snapchat ?? '',
    linkedin: AppConstants.profileData!.linkedin ?? '',
    twitter: AppConstants.profileData!.twitter ?? '',
  );

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorYellow,
      appBar: VeepMeepAppBar(
        title: 'Offering',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorYellow,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
          listener: (_, state) {
            if (state is BizEditSuccessState) {
              bloc.add(GetVeepDataEvent(
                  userId: appSharedData.getUserId()!,
                  shouldPop: state.shouldPopScreen));
            } else if (state is VeepDataSuccessState) {
              setState(() {
                AppConstants.profileData = state.output.first;
                if (AppConstants.profileData!.images!.isNotEmpty &&
                    AppConstants.profileData!.profileImage!.isEmpty) {
                  if (AppConstants.profileData!.images!.first.isNotEmpty) {
                    AppConstants.profileData!.profileImage =
                        AppConstants.profileData!.images!.first;
                  }
                }
              });
              if (state.shouldPop) {
                Navigator.pop(context);
              }
            }else if (state is UserImageChangeSuccessState) {
              setState(() {
                bloc.add(
                    GetVeepDataEvent(userId: appSharedData.getUserId()!, shouldPop: false));
              });
            } else if (state is ProfileSelectSuccessState) {
              setState(() {
                bloc.add(GetVeepDataEvent(
                    userId: appSharedData.getUserId()!, shouldPop: false));
              });
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 88, right: 24, left: 24),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          InkResponse(
                            onTap: () {
                              _changeImage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: CircleAvatar(
                                backgroundColor:
                                AppConstants.kIsBizAccount
                                    ? AppColors.colorGreen
                                    : AppColors.colorBlue,
                                radius: 60.h,
                                child: CircleAvatar(
                                  radius: 56.h,
                                  backgroundColor:
                                  AppColors.colorDisableWidget,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(76),
                                    child: AppConstants.profileData!
                                        .profileImage!.isNotEmpty
                                        ? Image.network(
                                      AppConstants.profileData!
                                          .profileImage!,
                                      fit: BoxFit.cover,
                                    )
                                        : profileImage != null
                                        ? Image.memory(
                                      profileImage!,
                                      fit: BoxFit.cover,
                                    )
                                        : Icon(
                                      CupertinoIcons.person,
                                      size: 60.h,
                                      color: AppColors
                                          .borderColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5.h,
                            child: InkWell(
                              onTap: () {
                                _changeImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.colorGray50,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0,
                                            3), // changes position of shadow
                                      ),
                                    ]),
                                child: SvgPicture.asset(
                                  AppImages.icPencil,
                                  color: AppConstants.kIsBizAccount
                                      ? AppColors.colorGreen
                                      : AppColors.colorBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      maxLength: 500,
                      title: 'My Product/Service name',
                      subtitle: veepData.serviceName!,
                      onTap: () {
                        _changeAppDialog(
                            value: veepData.serviceName!,
                            borderRadius: 25,
                            maxLength: 500,
                            onSubmit: (name) {
                              Navigator.pushNamed(
                                      context, Routes.kVerifyOtpView,
                                      arguments: OtpArgs(
                                          otpUseCase: OTPUseCase.PROFILE_EDIT,
                                          email: appSharedData
                                              .getEmailAddress()
                                              .toString(),
                                          isGenerated: true))
                                  .then((value) {
                                if (value != null && value is bool && value) {
                                  addBloc(AppConstants.profileData!.veepId!,
                                      name, false);
                                }
                              });
                              setState(() {
                                veepData.serviceName = name;
                              });
                            },
                            title: 'Product/Service name');
                      },
                    ),
                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      title: 'Slogan',
                      subtitle: veepData.slogan!,
                      onTap: () {
                        _changeAppDialog(
                            value: veepData.slogan!,
                            borderRadius: 25,
                            onSubmit: (slogan) {
                              setState(() {
                                veepData.slogan = slogan;
                              });
                            },
                            title: 'Slogan');
                      },
                    ),
                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      title: 'Living in',
                      subtitle: getSubtitle(veepData),
                      onTap: () {
                        _selectLocationDialog(
                            onSubmitCountry: (country) {
                              //editProfile(country: country);
                              setState(() {
                                veepData.country = country;
                              });
                            },
                            onSubmitState: (state) {
                              //editProfile(state: state);
                              if (state != 'Choose State') {
                                setState(() {
                                  veepData.province = state;
                                });
                              }
                            },
                            onSubmitCity: (city) {
                              //(city: city);
                              if (city != 'Choose City') {
                                setState(() {
                                  veepData.city = city;
                                });
                              }
                            },
                            title: 'Living in');
                      },
                    ),

                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      title: 'Neighborhood',
                      subtitle: veepData.neighborhood??'',
                      onTap: () {
                        _changeAppDialog(
                            value: veepData.neighborhood??'',
                            borderRadius: 25,
                            onSubmit: (slogan) {
                              setState(() {
                                veepData.neighborhood = slogan;
                              });
                            },
                            title: 'Neighborhood');
                      },
                    ),
                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      title: 'Product/Service Description',
                      subtitle: veepData.description!,
                      onTap: () {
                        _changeAppDialog(
                            value: veepData.description!,
                            borderRadius: 25,
                            onSubmit: (description) {
                              setState(() {
                                veepData.description = description;
                              });
                            },
                            title: 'Product/Service Description');
                      },
                    ),
                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      title: 'Product/Service Type',
                      subtitle: getServiceTypeString(veepData.serviceType!),
                      onTap: () {
                        showCustomDialog(
                          onTap: () {
                            setState(() {});
                          },
                          body: StatefulBuilder(builder: (context, setState) {
                            return Column(
                              children: [
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
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
                                  groupValue: veepData.serviceType,
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: ((value) {
                                    setState(() {
                                      veepData.serviceType = value.toString();
                                    });
                                  }),
                                ),
                              ],
                            );
                          }),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overview pdf',
                          style: TextStyle(
                              color: AppColors.colorGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.kFontSize18),
                        ),
                        const SizedBox(
                          height: 08,
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
                                      withData: true);
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
                              InkResponse(
                                onTap:() async {
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
                                        withData: true);
                                    if (result != null) {
                                      setState(() {
                                        file = result.files.first.bytes;
                                        fileExtension = result.files.first.extension;
                                      });
                                    }
                                  }
                                },
                                child: SvgPicture.asset(
                                  file != null || veepData.pdf!.isNotEmpty
                                      ? AppImages.icDeleteAttachment
                                      : AppImages.icAttachment,
                                  width: 8,
                                  height: 18,
                                  color: file != null
                                      ? AppColors.colorGreen
                                      : AppColors.colorGray700,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                file != null || veepData.pdf!.isNotEmpty
                                    ? 'Attached'
                                    : "Upload",
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
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                          color: AppColors.colorGray700,
                        ),
                      ],
                    ),
                    AppDataComponent(
                      backgroundColor: AppColors.colorYellow,
                      titleColor: AppColors.colorGreen,
                      subtitleColor: AppColors.colorBlue,
                      title: 'Website @ Socials',
                      subtitle: getLinks(veepData),
                      onTap: () {
                        _changeWebDialog(
                          title: 'Website & Socials',
                          value1: veepData.fb!,
                          value2: veepData.instagram!,
                          value3: veepData.linkedin!,
                          value4: veepData.snapchat!,
                          value5: veepData.web!,
                          value6: veepData.twitter!,
                          onSubmitFacebook: (String fb) {
                            //editProfile(fb: fb);
                            setState(() {
                              veepData.fb = fb;
                            });
                          },
                          onSubmitInstagram: (String insta) {
                            //editProfile(insta: insta);
                            setState(() {
                              veepData.instagram = insta;
                            });
                          },
                          onSubmitLinkedIn: (String linkin) {
                            // editProfile(linkin: linkin);
                            setState(() {
                              veepData.linkedin = linkin;
                            });
                          },
                          onSubmitSnapchat: (String snpcht) {
                            //(snpcht: snpcht);
                            setState(() {
                              veepData.snapchat = snpcht;
                            });
                          },
                          onSubmitWebsite: (String web) {
                            // editProfile(web: web);
                            setState(() {
                              veepData.web = web;
                            });
                          },
                          onSubmitTwitter: (String twitr) {
                            //editProfile(twtr: twitr);
                            setState(() {
                              veepData.twitter = twitr;
                            });
                          },
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text("Automated Away message",
                              style: TextStyle(
                                  color: AppColors.colorGreen,
                                  fontSize: AppDimensions.kFontSize18,
                                  fontWeight: FontWeight.w600)),
                        ),
                        AppSwitch(
                            value: automatedAwayMassage,
                            onChanged: ((value) {
                              setState(() {
                                automatedAwayMassage = value;
                              });
                            })),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.colorGray700,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset:
                              const Offset(0, -2), // changes position of shadow
                        ),
                      ],
                      color: AppColors.colorGray50,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: AppButton(
                            width: 115.w,
                            buttonText: 'Done',
                            buttonColor: AppConstants.kIsBizAccount
                                ? AppColors.colorGreen
                                : AppColors.colorGreen,
                            onTapButton: () {
                              bloc.add(BizEditEvent(
                                  bizEditRequest: BizEditRequest(
                                      userId: appSharedData.getUserId()!,
                                      serviceName: veepData.serviceName ?? '',
                                      slogan: veepData.slogan ?? '',
                                      neighborhood: veepData.neighborhood??'',
                                      serviceDescription:
                                          veepData.description ?? '',
                                      serviceType:
                                          int.parse(veepData.serviceType!),
                                      country: veepData.country ?? '',
                                      province: veepData.province ?? '',
                                      city: veepData.city ?? '',
                                      fb: veepData.fb ?? '',
                                      instagram: veepData.instagram ?? '',
                                      linkedin: veepData.linkedin ?? '',
                                      snapchat: veepData.snapchat ?? '',
                                      twitter: veepData.twitter ?? '',
                                      web: veepData.web ?? '',
                                      extension: fileExtension,
                                      file: file),
                                  shouldPopScreen: true));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addBloc(int userId, String? serviceName, bool shouldPop) {
    bloc.add(BizEditEvent(
        bizEditRequest: BizEditRequest(
            neighborhood:veepData.neighborhood??'',
            userId: appSharedData.getUserId()!,
            serviceName: veepData.serviceName ?? '',
            slogan: veepData.slogan ?? '',
            serviceDescription: veepData.description ?? '',
            serviceType: int.parse(veepData.serviceType!),
            country: veepData.country ?? '',
            province: veepData.province ?? '',
            city: veepData.city ?? '',
            fb: veepData.fb ?? '',
            instagram: veepData.instagram ?? '',
            linkedin: veepData.linkedin ?? '',
            snapchat: veepData.snapchat ?? '',
            twitter: veepData.twitter ?? '',
            web: veepData.web ?? '',
            extension: fileExtension,
            file: file),
        shouldPopScreen: shouldPop));
  }

  _changeAppDialog(
      {required String value,
      required Function(String) onSubmit,
      required String title,
      int? maxLines,
      int? maxLength,
      double? borderRadius}) {
    final controller = TextEditingController(text: value);
    showAppDialog(
        title: 'Edit $title',
        dialogContentWidget: AppTextField(
          maxLines: maxLines ?? 4,
          maxLength: maxLength ?? 9000,
          controller: controller,
          borderRadius: borderRadius,
        ),
        positiveButtonText: "Save",
        negativeButtonText: "Cancel",
        onPositiveCallback: () {
          if (controller.text.isNotEmpty) {
            onSubmit(controller.text);
          } else {
            showAppDialog(
                title: ErrorMessages.TITLE_ERROR,
                message: '$title can not be empty');
          }
        });
  }

  void _changeWebDialog({
    required String title,
    required String value1,
    required String value2,
    required String value3,
    required String value4,
    required String value5,
    required String value6,
    required Function(String) onSubmitFacebook,
    required Function(String) onSubmitInstagram,
    required Function(String) onSubmitLinkedIn,
    required Function(String) onSubmitSnapchat,
    required Function(String) onSubmitWebsite,
    required Function(String) onSubmitTwitter,
  }) {
    final facebookController = TextEditingController(text: value1);
    final instagramController = TextEditingController(text: value2);
    final linkedinController = TextEditingController(text: value3);
    final snapchatController = TextEditingController(text: value4);
    final webSiteController = TextEditingController(text: value5);
    final twitterController = TextEditingController(text: value6);

    showAppDialog(
      title: 'Edit Social Media Profiles',
      dialogContentWidget: SizedBox(
        height: 440.h,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                maxLines: 1,
                controller: facebookController,
                labelText: 'Facebook',
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                maxLines: 1,
                controller: instagramController,
                labelText: 'Instagram',
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                maxLines: 1,
                controller: linkedinController,
                labelText: 'LinkedIn',
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                maxLines: 1,
                controller: snapchatController,
                labelText: 'Snapchat',
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                maxLines: 1,
                controller: webSiteController,
                labelText: 'Website',
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                maxLines: 1,
                controller: twitterController,
                labelText: 'Twitter',
              ),
            ],
          ),
        ),
      ),
      positiveButtonText: "Save",
      negativeButtonText: "Cancel",
      onPositiveCallback: () {
        onSubmitFacebook(facebookController.text);
        onSubmitInstagram(instagramController.text);
        onSubmitLinkedIn(linkedinController.text);
        onSubmitSnapchat(snapchatController.text);
        onSubmitTwitter(twitterController.text);
        onSubmitWebsite(webSiteController.text);
      },
    );

    // Repeat the same structure for the remaining 4 controllers.
  }

  String getSubtitle(VeepData veepData) {
    String city = veepData.city!;
    String province = veepData.province!;
    String country = veepData.country!;

    String result = "";
    if (!city.isEmpty) {
      result += city + ", ";
    }
    if (!province.isEmpty) {
      result += province + ", ";
    }
    if (!country.isEmpty) {
      result += country;
    }
    if (result.endsWith(", ")) {
      result = result.substring(0, result.length - 2);
    }

    return result;
  }

  _showImagePicker(Function(int) selectionMode) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Profile image',
              style: TextStyle(color: AppColors.fontColorDark)),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('Capture from camera',
                  style: TextStyle(
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue)),
              onPressed: () {
                selectionMode(0);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Pick from gallery',
                  style: TextStyle(
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue)),
              onPressed: () {
                selectionMode(1);
                Navigator.pop(
                  context,
                );
              },
            ),

            CupertinoActionSheetAction(
              child: Text('Choose from my photos',
                  style: TextStyle(
                      color: AppConstants.kIsBizAccount
                          ? AppColors.colorGreen
                          : AppColors.colorBlue)),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, Routes.kMyPhotosPickerView)
                    .then((value) {
                  if (value != null && value is int) {
                    bloc.add(
                      ProfileSelectEvent(
                        profileSelectRequest: ProfileSelectRequest(
                            userId: AppConstants.profileData!.veepId!,
                            profilePicture: 'profile_picture${value + 1}'),
                      ),
                    );
                  }
                });
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.colorFailed)),
          )),
    );
  }

  _changeImage() {
    _showImagePicker((mode) {
      AppPermissionManager.requestCameraPermission(context, () async {
        XFile? photo = await ImagePicker().pickImage(
            source: mode == 0 ? ImageSource.camera : ImageSource.gallery,
            imageQuality: 40,
            maxHeight: 400,
            maxWidth: 400);

        CroppedFile? cropped = await ImageCropper().cropImage(
            sourcePath: photo!.path,
            compressQuality: 60,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            cropStyle: CropStyle.circle);

        if (cropped != null) {
          profileImage = await cropped.readAsBytes();
          extension = path.extension(cropped.path);
          setState(() {});

          bloc.add(
            UserImageChangeEvent(
              userImageChangeRequest: UserImageChangeRequest(
                  userId: appSharedData.getUserId()!,
                  extension: extension!,
                  updateBy: appSharedData.getUserId()!,
                  profile: profileImage!),
            ),
          );
        }
      });
    });
  }

  String getLinks(VeepData veepData) {
    String fb = veepData.fb!;
    String instagram = veepData.instagram!;
    String linkedin = veepData.linkedin!;
    String snapchat = veepData.snapchat!;
    String web = veepData.web!;
    String twitter = veepData.twitter!;

    String result = "";
    if (fb.isNotEmpty) {
      result += fb + ", ";
    }
    if (instagram.isNotEmpty) {
      result += instagram + ", ";
    }
    if (linkedin.isNotEmpty) {
      result += linkedin + ", ";
    }
    if (snapchat.isNotEmpty) {
      result += snapchat + ", ";
    }
    if (web.isNotEmpty) {
      result += web + ", ";
    }
    if (twitter.isNotEmpty) {
      result += twitter;
    }
    if (result.endsWith(", ")) {
      result = result.substring(0, result.length - 2);
    }

    return result;
  }

  String getServiceTypeString(String serviceType) {
    switch (serviceType) {
      case '1':
        return 'Consulting';
      case '2':
        return 'Event Spaces & Conferencing';
      case '3':
        return 'Fashion';
      case '4':
        return 'Food & Beverage';
      case '5':
        return 'Health & Medical';
      case '6':
        return 'Leisure & Travel';
      case '7':
        return 'Sport';
      case '8':
        return 'Sustainable & Eco Environment';
      case '9':
        return 'Wellbeing & Fitness';
      case '10':
        return 'Multiple Offerings';
      case '11':
        return 'Other';
      default:
        return 'Unknown';
    }
  }

  _selectLocationDialog(
      {required Function(String) onSubmitCountry,
      required Function(String) onSubmitState,
      required Function(String) onSubmitCity,
      required String title}) {
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    showAppDialog(
        title: 'Edit $title',
        dialogContentWidget: Column(
          children: [
            SelectState(
              style: TextStyle(
                  fontSize: AppDimensions.kFontSize16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorGray700),
              // dropdownColor: AppColors.colorGray700,
              onCountryChanged: (value) {
                setState(() {
                  veepData.country = value.substring(4, value.length).trim();
                  veepData.province = '';
                  veepData.city = '';
                });
              },
              onStateChanged: (value) {
                setState(() {
                  if (value != "Choose State") {
                    veepData.province = value;
                    veepData.city = '';
                  }
                });
              },
              onCityChanged: (value) {
                setState(() {
                  if (value != "Choose City") {
                    veepData.city = value;
                  }
                });
              },
            )
          ],
        ),
        positiveButtonText: "Save",
        negativeButtonText: "Cancel",
        onPositiveCallback: () {
          if (veepData.country!.isNotEmpty &&
              veepData.province!.isNotEmpty &&
              veepData.province!.isNotEmpty) {
            onSubmitCountry(veepData.country!);
            onSubmitState(veepData.province!);
            onSubmitCity(veepData.city!);
          } else if (veepData.country!.isNotEmpty &&
              veepData.province!.isNotEmpty) {
            onSubmitCountry(veepData.country!);
            onSubmitState(veepData.province!);
          } else if (veepData.country!.isNotEmpty) {
            onSubmitCountry(veepData.country!);
          } else {
            showAppDialog(
                title: ErrorMessages.TITLE_ERROR,
                message: 'Country can not be empty');
          }
        });
  }

  editOffering({
    String? service,
    String? slogan,
    String? location,
    String? description,
    String? type,
    String? name,
    String? web,
    String? job,
    String? fb,
    String? linkin,
    String? twtr,
    String? snpcht,
    String? insta,
    int? vegan,
  }) {}

  bool _isValid() {
    if (veepData.serviceName == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "My product/service name cannot be empty");
      return false;
    } else if (veepData.slogan == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR, message: "Slogan cannot be empty");
      return false;
    } else if (veepData.description == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Product/service description cannot be empty");
      return false;
    } else if (veepData.serviceType == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Product/Service type must be selected");
      return false;
    } else if (veepData.country == null) {
      showAppDialog(
          title: ErrorMessages.TITLE_ERROR,
          message: "Country must be selected");
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
