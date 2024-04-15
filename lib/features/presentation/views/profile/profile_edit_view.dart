import 'dart:typed_data';
import 'dart:ui';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:veep_meep/features/data/models/requests/regular_edit_request.dart';
import 'package:veep_meep/features/data/models/responses/veep_data_response.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_event.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/common/app_text_field.dart';
import 'package:veep_meep/features/presentation/common/app_title_text.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/profile_select_request.dart';
import '../../../data/models/requests/user_image_change_request.dart';
import '../../../domain/entities/personal_data_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_data_compo.dart';
import '../../common/app_subtitle_text.dart';
import '../../common/app_switch.dart';
import '../base_view.dart';
import '../sign in/verify_otp_view.dart';

class ProfileEditView extends BaseView {
  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends BaseViewState<ProfileEditView> {
  var bloc = injection<AuthBloc>();
  List userDataList = [];
  String? extension;
  Uint8List? profileImage;
  PersonalDataEntity personalDataEntity = PersonalDataEntity();
  final dotController = PageController();
  final _date = TextEditingController();
  bool automatedDeclineMessageValue = true;
  final VeepData veepData = VeepData(
    accountType: AppConstants.profileData!.accountType,
    veepId: AppConstants.profileData!.veepId ?? 0,
    age: AppConstants.profileData!.age ?? 0,
    name: AppConstants.profileData!.name ?? '',
    fullName: AppConstants.profileData!.fullName ?? '',
    dob: AppConstants.profileData!.dob ?? DateTime.now(),
    bio: AppConstants.profileData!.bio ?? '',
    city: AppConstants.profileData!.city ?? '',
    country: AppConstants.profileData!.country ?? '',
    province: AppConstants.profileData!.province ?? '',
    gender: AppConstants.profileData!.gender ?? '1',
    veganScale: AppConstants.profileData!.veganScale ?? '1',
    hobbies: AppConstants.profileData!.hobbies ?? '',
    designation: AppConstants.profileData!.designation ?? '',
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
      backgroundColor: AppColors.colorBorder,
      appBar: VeepMeepAppBar(
        backgroundColor: AppColors.colorBorder,
        title: 'Edit Profile',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                width: 04,
                height: 04,
                AppImages.icContextMenu,
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is RegularEditSuccessState) {
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
              } else if (state is UserImageChangeSuccessState) {
                setState(() {
                  bloc.add(GetVeepDataEvent(
                      userId: appSharedData.getUserId()!, shouldPop: false));
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
                Container(
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
                                  backgroundColor: AppConstants.kIsBizAccount
                                      ? AppColors.colorGreen
                                      : AppColors.colorBlue,
                                  radius: 60.h,
                                  child: CircleAvatar(
                                    radius: 56.h,
                                    backgroundColor:
                                        AppColors.colorDisableWidget,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(76),
                                      child: AppConstants.profileData!
                                              .profileImage!.isNotEmpty
                                          ? Image.network(
                                              AppConstants
                                                  .profileData!.profileImage!,
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
                                                  color: AppColors.borderColor,
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
                                          color: Colors.grey.withOpacity(0.5),
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
                        title: 'Full Name',
                        subtitle: veepData.name!,
                        onTap: () {
                          _changeAppDialog(
                              value: veepData.name!,
                              borderRadius: 25,
                              onSubmit: (name) {
                                // editProfile(about: newAbout);
                                Navigator.pushNamed(
                                        context, Routes.kVerifyOtpView,
                                        arguments: OtpArgs(
                                            email: appSharedData
                                                .getEmailAddress()
                                                .toString(),
                                            isGenerated: true,
                                            otpUseCase:
                                                OTPUseCase.PROFILE_EDIT))
                                    .then((value) {
                                  if (value != null && value is bool && value) {
                                    addBloc(
                                        AppConstants.profileData!.veepId!,
                                        name,
                                        AppConstants.profileData!.dob!,
                                        false);
                                  }
                                });
                                setState(() {
                                  veepData.name = name;
                                });
                              },
                              title: 'Full Name');
                        },
                      ),
                      AppDataComponent(
                        title: 'About ${AppConstants.profileData!.name}',
                        subtitle: veepData.bio!,
                        onTap: () {
                          _changeAppDialog(
                              value: veepData.bio!,
                              borderRadius: 25,
                              onSubmit: (newAbout) {
                                // editProfile(about: newAbout);
                                setState(() {
                                  veepData.bio = newAbout;
                                });
                              },
                              title: 'About');
                        },
                      ),
                      AppDataComponent(
                        title: 'Date of Birth',
                        subtitle:
                            DateFormat('yyyy-MM-dd').format(veepData.dob!),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: veepData.dob!,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                                  .subtract(const Duration(days: 365 * 16)));

                          if (pickedDate != null) {
                            Navigator.pushNamed(context, Routes.kVerifyOtpView,
                                    arguments: OtpArgs(
                                        email: appSharedData
                                            .getEmailAddress()
                                            .toString(),
                                        isGenerated: true,
                                        otpUseCase: OTPUseCase.PROFILE_EDIT))
                                .then((value) {
                              if (value != null && value is bool && value) {
                                addBloc(
                                    AppConstants.profileData!.veepId!,
                                    AppConstants.profileData!.name!,
                                    pickedDate,
                                    false);
                              }
                            });
                            setState(() {
                              _date.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              veepData.dob = pickedDate;
                            });
                          }
                        },
                      ),
                      AppDataComponent(
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
                        title: 'Gender',
                        subtitle: veepData.gender != null
                            ? getGenderName(veepData.gender!)
                            : 'Female',
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
                                      subtitle: 'Female',
                                      fontSize: AppDimensions.kFontSize16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorGray700,
                                    ),
                                    value: "1",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.gender,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.gender = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: 'Male',
                                        fontSize: AppDimensions.kFontSize16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.colorGray700),
                                    value: "2",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.gender,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.gender = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "Non-Binary",
                                        fontSize: AppDimensions.kFontSize16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.colorGray700),
                                    value: "3",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.gender,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.gender = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "Transwoman",
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w400),
                                    value: "4",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.gender,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.gender = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "Transman",
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w400),
                                    value: "5",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.gender,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.gender = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "You Decide",
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w400),
                                    value: "6",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.gender,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.gender = value.toString();
                                      });
                                    }),
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                      ),
                      AppDataComponent(
                        title: 'Hobbies',
                        subtitle: veepData.hobbies!,
                        onTap: () {
                          _changeAppDialog(
                              borderRadius: 25,
                              value: veepData.hobbies!,
                              onSubmit: (newHobbies) {
                                //  editProfile(hobbies: newHobbies);
                                setState(() {
                                  veepData.hobbies = newHobbies;
                                });
                              },
                              title: 'Hobbies');
                        },
                      ),
                      AppDataComponent(
                        title: 'Motto | Job Title',
                        subtitle: veepData.designation!,
                        onTap: () {
                          _changeAppDialog(
                              value: veepData.designation!,
                              borderRadius: 25,
                              onSubmit: (newJob) {
                                //editProfile(job: newJob);
                                setState(() {
                                  veepData.designation = newJob;
                                });
                              },
                              title: 'Motto | Job Title');
                        },
                      ),
                      AppDataComponent(
                        title: 'Website @ Socials',
                        subtitle: getLinks(veepData),
                        onTap: () {
                          _changeWebDialog(
                            title: 'Website @ Socials',
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
                      AppDataComponent(
                        title: 'My Vegan Scale',
                        subtitle: veepData.veganScale != null
                            ? getProfileCategory(veepData.veganScale!)
                            : "Starting out",
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
                                      subtitle: "Starting out",
                                      fontSize: AppDimensions.kFontSize16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorGray700,
                                    ),
                                    value: "1",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.veganScale,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.veganScale = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "Intermediate",
                                        fontSize: AppDimensions.kFontSize16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.colorGray700),
                                    value: "2",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.veganScale,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.veganScale = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "+2 years",
                                        fontSize: AppDimensions.kFontSize16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.colorGray700),
                                    value: "3",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.veganScale,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.veganScale = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "Flexitarian",
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w400),
                                    value: "4",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.veganScale,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.veganScale = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle:
                                            "I've got more avocados than you",
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w400),
                                    value: "5",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.veganScale,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.veganScale = value.toString();
                                      });
                                    }),
                                  ),
                                  RadioListTile(
                                    title: AppSubText(
                                        subtitle: "I'm the vegan President ;-)",
                                        fontSize: AppDimensions.kFontSize16,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w400),
                                    value: "6",
                                    activeColor: AppConstants.kIsBizAccount
                                        ? AppColors.colorGreen
                                        : AppColors.colorBlue,
                                    groupValue: veepData.veganScale,
                                    dense: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: ((value) {
                                      setState(() {
                                        veepData.veganScale = value.toString();
                                      });
                                    }),
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: AppTitleText(
                                  title: 'Automated Decline Message')),
                          AppSwitch(
                              value: automatedDeclineMessageValue,
                              onChanged: ((value) {
                                setState(() {
                                  this.automatedDeclineMessageValue = value;
                                });
                              })),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColors.colorGray700,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                /*Align(
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
                            offset: const Offset(
                                0, -2), // changes position of shadow
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
                                  : AppColors.colorBlue,
                              onTapButton: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),*/

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.colorGray50,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset:
                              const Offset(0, -2), // changes position of shadow
                        ),
                      ],
                    ),
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
                                  : AppColors.colorBlue,
                              onTapButton: () {
                                bloc.add(RegularEditEvent(
                                    regularEditRequest: RegularEditRequest(
                                      userId: AppConstants.profileData!.veepId!,
                                      fullName: veepData.name ??
                                          AppConstants.profileData!.name!,
                                      dob: DateFormat('yyyy-MM-dd')
                                          .format(veepData.dob!),
                                      designation: veepData.designation ??
                                          AppConstants
                                              .profileData!.designation!,
                                      bio: veepData.bio ??
                                          AppConstants.profileData!.bio!,
                                      gender: int.parse(veepData.gender!),
                                      veganScale:
                                          int.parse(veepData.veganScale!),
                                      fb: veepData.fb ??
                                          AppConstants.profileData!.fb!,
                                      instagram: veepData.instagram ??
                                          AppConstants.profileData!.instagram!,
                                      linkedin: veepData.linkedin ??
                                          AppConstants.profileData!.linkedin!,
                                      snapchat: veepData.snapchat ??
                                          AppConstants.profileData!.snapchat!,
                                      twitter: veepData.twitter ??
                                          AppConstants.profileData!.twitter!,
                                      web: veepData.web ??
                                          AppConstants.profileData!.web!,
                                      hobbies: veepData.hobbies ??
                                          AppConstants.profileData!.hobbies!,
                                      city: veepData.city ??
                                          AppConstants.profileData!.city!,
                                      province: veepData.province ??
                                          AppConstants.profileData!.province!,
                                      country: veepData.country ??
                                          AppConstants.profileData!.country!,
                                    ),
                                    shouldPopScreen: true));
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  addBloc(int userId, String? name, DateTime? dob, bool shouldPop) {
    bloc.add(RegularEditEvent(
        regularEditRequest: RegularEditRequest(
          userId: userId,
          fullName: name ?? AppConstants.profileData!.name!,
          dob: DateFormat('yyyy-MM-dd').format(dob!),
          designation:
              veepData.designation ?? AppConstants.profileData!.designation!,
          bio: veepData.bio ?? AppConstants.profileData!.bio!,
          gender: int.parse(veepData.gender!),
          veganScale: int.parse(veepData.veganScale!),
          fb: veepData.fb ?? AppConstants.profileData!.fb!,
          instagram: veepData.instagram ?? AppConstants.profileData!.instagram!,
          linkedin: veepData.linkedin ?? AppConstants.profileData!.linkedin!,
          snapchat: veepData.snapchat ?? AppConstants.profileData!.snapchat!,
          twitter: veepData.twitter ?? AppConstants.profileData!.twitter!,
          web: veepData.web ?? AppConstants.profileData!.web!,
          hobbies: veepData.hobbies ?? AppConstants.profileData!.hobbies!,
          city: veepData.city ?? AppConstants.profileData!.city!,
          province: veepData.province ?? AppConstants.profileData!.province!,
          country: veepData.country ?? AppConstants.profileData!.country!,
        ),
        shouldPopScreen: shouldPop));
  }

  _changeAppDialog(
      {required String value,
      required Function(String) onSubmit,
      required String title,
      int? maxLines,
      double? borderRadius}) {
    final controller = TextEditingController(text: value);
    showAppDialog(
        title: 'Edit $title',
        dialogContentWidget: AppTextField(
          maxLines: maxLines ?? 4,
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

/*  _editRadioButtons(
      {required int value,
        required Function(int) onSubmit,
        required String title,
        required List<String> radioButtonTexts}) {
    int initialValue = value ;
    int selectedRadio = initialValue;

    showAppDialog(
        title: 'Edit $title',
        dialogContentWidget: RadioButton(
          radioButtonTexts: radioButtonTexts,
          onRadioSelected: (int value) {
            setState(() {
              selectedRadio = value;
            });
          },
        ),
        positiveButtonText: "Save",
        negativeButtonText: "Cancel",
        onPositiveCallback: () {
          if (selectedRadio > 0 && selectedRadio <= radioButtonTexts.length) {
            onSubmit(selectedRadio);
          } else {
            showAppDialog(
                title: ErrorMessages.TITLE_ERROR,
                message: '$title not selected');
          }
        });
  }*/

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

  String getProfileCategory(String categoryValue) {
    switch (categoryValue) {
      case '1':
        return 'Starting out';
      case '2':
        return 'Intermediate';
      case '3':
        return '+2 years';
      case '4':
        return 'Flexitarian';
      case '5':
        return 'I\'ve got more avocados than you';
      case '6':
        return 'I\'m the vegan President ;-)';
      default:
        return '';
    }
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
    final facebookController = TextEditingController(text: value1 ?? '');
    final instagramController = TextEditingController(text: value2 ?? '');
    final linkedinController = TextEditingController(text: value3);
    final snapchatController = TextEditingController(text: value4 ?? '');
    final webSiteController = TextEditingController(text: value5 ?? '');
    final twitterController = TextEditingController(text: value6 ?? '');

    showAppDialog(
      title: 'Edit Social Media',
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
        // if all fields are not empty, call the onSubmit functions for each controller
      },
    );
  }

  void editProfile({
    String? about,
    int? age,
    String? country,
    String? city,
    String? state,
    int? gender,
    String? hobbies,
    String? job,
    String? fb,
    String? linkin,
    String? twtr,
    String? web,
    String? snpcht,
    String? insta,
    int? vegan,
  }) {}

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

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
