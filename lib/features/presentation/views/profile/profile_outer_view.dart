import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/utils/app_constants.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/navigation_routes.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../utils/app_images.dart';
import '../../../data/models/requests/user_image_change_request.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';
import 'pdf_view.dart';

class ProfileOuterView extends BaseView {
  @override
  State<ProfileOuterView> createState() => _ProfileOuterViewState();
}

class _ProfileOuterViewState extends BaseViewState<ProfileOuterView> {
  var bloc = injection<AuthBloc>();
  String? extension;
  Uint8List? profileImage;
  bool isUpdated = false;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.fontColorDark,
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is UserImageChangeSuccessState) {
                setState(() {
                  isUpdated = true;
                  bloc.add(
                      GetVeepDataEvent(userId: appSharedData.getUserId()!, shouldPop: true));
                });
              } else if (state is VeepDataSuccessState) {
                setState(() {
                  AppConstants.profileData = state.output.first;
                });
              }
            },
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    AppConstants.kIsBizAccount
                        ? AppImages.imgProfileYellowBackground
                        : AppImages.imgProfileWhiteBackground,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 30),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.kSettingsView).then((value) {
                                              setState(() {

                                              });
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        width: 30,
                                        height: 30,
                                        'images/svg/ic_settings.svg',
                                        color: AppConstants.kIsBizAccount
                                            ? AppColors.colorGreen
                                            : AppColors.colorBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    InkResponse(
                                      onTap: () {
                                        /*Navigator.pushNamed(
                                            context, Routes.kProfileInnerView).then((value){
                                              setState(() {

                                              });
                                        });*/
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
                                          Navigator.pushNamed(
                                              context, Routes.kProfileInnerView).then((value){
                                            setState(() {

                                            });
                                          });
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
                                const SizedBox(
                                  height: 08,
                                ),
                                Text(
                                  AppConstants.kIsBizAccount
                                      ? AppConstants.profileData!.serviceName ??
                                          ''
                                      : '${AppConstants.profileData!.name ?? ''}, ${AppConstants.profileData!.age ?? ''}',
                                  style: TextStyle(
                                      color: AppConstants.kIsBizAccount
                                          ? AppColors.colorBlue
                                          : AppColors.colorGray700,
                                      fontSize: AppDimensions.kFontSize24,
                                      fontWeight: AppConstants.kIsBizAccount
                                          ? FontWeight.w600
                                          : FontWeight.w700),
                                ),
                                AppConstants.kIsBizAccount
                                    ? RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: _getBizLocation(),
                                            style: TextStyle(
                                                fontSize:
                                                    AppDimensions.kFontSize12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.colorGray700),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' 10 miles',
                                                style: TextStyle(
                                                    fontSize: AppDimensions
                                                        .kFontSize12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppConstants
                                                            .kIsBizAccount
                                                        ? AppColors.colorGreen
                                                        : AppColors.colorBlue),
                                              )
                                            ]),
                                      )
                                    : _getSocialText(),
                                Visibility(
                                  visible: AppConstants.kIsBizAccount,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      AppConstants.profileData!.slogan ?? '',
                                      style: TextStyle(
                                          color: AppConstants.kIsBizAccount
                                              ? AppColors.colorBlue
                                              : AppColors.colorGray700,
                                          fontSize: AppDimensions.kFontSize16,
                                          fontWeight: AppConstants.kIsBizAccount
                                              ? FontWeight.w400
                                              : FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: AppConstants.kIsBizAccount &&
                                      AppConstants.profileData!.pdf != null &&
                                      AppConstants.profileData!.pdf!.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: AppButton(
                                      width: 120,
                                      buttonColor: AppConstants.kIsBizAccount
                                          ? AppColors.colorGreen
                                          : AppColors.colorBlue,
                                      buttonText: 'Overview',
                                      onTapButton: () async {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.kPDFView,
                                          arguments: PDFViewArgs(
                                              fileName: '',
                                              filePath: AppConstants
                                                  .profileData!.pdf!),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: AppConstants.kIsBizAccount
                                        ? 'Get more reach\n '
                                        : 'Get more matches\n ',
                                    style: TextStyle(
                                        fontSize: AppDimensions.kFontSize24,
                                        color: AppColors.colorGray700,
                                        fontWeight: FontWeight.w600),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'across 6 other Continents',
                                        style: TextStyle(
                                            fontSize: AppDimensions.kFontSize16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.colorGray700),
                                      )
                                    ]),
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.center,
                                child: Wrap(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: AppConstants.kIsBizAccount
                                          ? AppColors.colorGreen
                                          : AppColors.colorBlue,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.circle,
                                      color: AppColors.colorGray400,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.circle,
                                      color: AppColors.colorGray400,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.circle,
                                      color: AppColors.colorGray400,
                                      size: 12,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              AppButton(
                                  buttonText: AppConstants.kIsBizAccount
                                      ? 'get pumpkin'
                                      : 'get mango',
                                  buttonColor: Colors.black,
                                  width: 300.h,
                                  onTapButton: () {

                                  }),
                              const SizedBox(height: 30),
                            ],
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String _getBizLocation() {
    String location = '';
    if (AppConstants.profileData!.city != null &&
        AppConstants.profileData!.city!.isNotEmpty) {
      location += '${AppConstants.profileData!.city!}, ';
    }

    if (AppConstants.profileData!.province != null &&
        AppConstants.profileData!.province!.isNotEmpty) {
      location += '${AppConstants.profileData!.province!}, ';
    }

    if (AppConstants.profileData!.country != null &&
        AppConstants.profileData!.country!.isNotEmpty) {
      location += AppConstants.profileData!.country!;
    }
    return location;
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
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorGray700),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.web!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
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
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorGray700),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.fb!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
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
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorGray700),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.instagram!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
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
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorGray700),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.linkedin!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
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
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorGray700),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.snapchat!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
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
                    fontSize: AppDimensions.kFontSize12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorGray700),
                children: <TextSpan>[
                  TextSpan(
                    text: AppConstants.profileData!.twitter!,
                    style: TextStyle(
                        fontSize: AppDimensions.kFontSize12,
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
            )
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

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}

class ProfileContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 8, size.height - 75,
        (size.width / 4) + 50, size.height - 75);
    path.lineTo(((size.width * 3) / 4) - 50, size.height - 70);
    path.quadraticBezierTo(
        (size.width * 7) / 8, size.height - 70, size.width, size.height - 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
