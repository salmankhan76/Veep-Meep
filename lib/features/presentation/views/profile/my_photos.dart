import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../error/messages.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_dimensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/add_uimage_request.dart';
import '../../../domain/entities/grid_image_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../common/app_button.dart';
import '../base_view.dart';

class MyPhotosView extends BaseView {
  @override
  State<MyPhotosView> createState() => _MyPhotosViewState();
}

class _MyPhotosViewState extends BaseViewState<MyPhotosView> {
  var bloc = injection<AuthBloc>();
  int _selectedIndex = 0;
  List<GridImageEntity> gridImageEntities = [];

  @override
  void initState() {
    for (int i = 0; i < 9; i++) {
      gridImageEntities.add(
        GridImageEntity(
            orderId: i, networkImage: AppConstants.profileData!.images![i]),
      );
    }
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: 'My photos',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is AddImageSuccessState) {
                bloc.add(GetVeepDataEvent(userId: appSharedData.getUserId()!, shouldPop: false));
              }else if (state is VeepDataSuccessState) {
                setState(() {
                  AppConstants.profileData = state.output.first;
                  if (AppConstants.profileData!.images!.isNotEmpty &&
                      AppConstants.profileData!.profileImage!.isEmpty) {
                    AppConstants.profileData!.images!.forEach((element) {
                      if (element != null && element.isNotEmpty) {
                        AppConstants.profileData!.profileImage = element;
                      }
                    });
                  }
                });
                Navigator.pop(context);
              }
            },
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 08,
                  bottom: 80,
                ),
                child: Column(
                  children: [
                    /*Center(
                      child: Text(
                        "Use Drag'n'Drop to sort the photos!",
                        style: TextStyle(
                            fontSize: AppDimensions.kFontSize16,
                            fontWeight: FontWeight.w400,
                            color: AppConstants.kIsBizAccount
                                ? AppColors.colorBlue
                                : AppColors.colorGray700),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),*/
                    Expanded(
                      child: ReorderableGridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16),
                        onReorder: ((oldIndex, newIndex) {
                          GridImageEntity entity =
                              gridImageEntities.removeAt(oldIndex);
                          entity.orderId = newIndex;
                          gridImageEntities.insert(newIndex, entity);
                          setState(() {});
                        }),
                        children: gridImageEntities
                            .map(
                              (entity) => Container(
                                key: ValueKey(entity),
                                decoration: BoxDecoration(
                                    color: AppColors.colorGray50,
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    _showImagePicker((mode) {
                                      AppPermissionManager
                                          .requestCameraPermission(context,
                                              () async {
                                        XFile? photo = await ImagePicker()
                                            .pickImage(
                                                source: mode == 0
                                                    ? ImageSource.camera
                                                    : ImageSource.gallery,
                                                imageQuality: 20,
                                                maxHeight: 400,
                                                maxWidth: 400);

                                        CroppedFile? cropped =
                                            await ImageCropper().cropImage(
                                                sourcePath: photo!.path,
                                                compressQuality: 40,
                                                aspectRatio:
                                                    const CropAspectRatio(
                                                        ratioX: 1, ratioY: 1),
                                                cropStyle: CropStyle.rectangle);

                                        if (cropped != null) {
                                          entity.gridImage =
                                              await cropped.readAsBytes();
                                          entity.extension =
                                              path.extension(cropped.path);
                                          setState(() {});
                                        }
                                      });
                                    });
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: entity.gridImage != null ||
                                            entity.networkImage!.isNotEmpty
                                        ? Stack(
                                            children: [
                                              entity.gridImage != null
                                                  ? Image.memory(
                                                      entity.gridImage!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      entity.networkImage!,
                                                      fit: BoxFit.cover,
                                                    ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  padding:
                                                      const EdgeInsets.all(04),
                                                  decoration: BoxDecoration(
                                                    color: AppConstants
                                                            .kIsBizAccount
                                                        ? AppColors.colorGreen
                                                        : AppColors.colorBlue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.check,
                                                    size: 15,
                                                    color: AppColors
                                                        .fontColorWhite,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              padding: const EdgeInsets.all(04),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppConstants.kIsBizAccount
                                                        ? AppColors.colorGreen
                                                        : AppColors.colorBlue,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 15,
                                                color: AppColors.fontColorWhite,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              /*Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: AppColors.colorGray50,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkResponse(
                            child: SvgPicture.asset(AppImages.icLocation,
                                color: _selectedIndex == 1
                                    ? AppColors.colorBlue
                                    : Colors.black),
                            onTap: () {
                              onTabTapped(1);
                              Navigator.pushReplacementNamed(
                                  context, Routes.kDiscoverView);
                            }),
                        InkResponse(
                            child: SvgPicture.asset(AppImages.icFavourite,
                                color: _selectedIndex == 2
                                    ? AppColors.colorBlue
                                    : Colors.black),
                            onTap: () {
                              onTabTapped(2);
                              Navigator.pushReplacementNamed(
                                  context, Routes.kFavoriteView);
                            }),
                        InkResponse(
                            child: SvgPicture.asset(AppImages.icStar,
                                color: Colors.black),
                            onTap: () {
                              onTabTapped(3);
                            }),
                        InkResponse(
                            child: SvgPicture.asset(AppImages.icMessage,
                                color: Colors.black),
                            onTap: () {
                              onTabTapped(4);
                            }),
                        InkResponse(
                            child: SvgPicture.asset(AppImages.icProfile,
                                color: AppColors.colorBlue),
                            onTap: () {
                              onTabTapped(5);
                              Navigator.pushReplacementNamed(
                                  context, Routes.kHomeView);
                            }),
                      ],
                    ),
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
                              bloc.add(
                                AddImageEvent(
                                  addImageRequest: AddImageRequest(
                                      userId:
                                      appSharedData.getUserId() ?? 0,
                                      data: gridImageEntities),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ])),
      ),
    );
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
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.colorFailed)),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;

      ///call your PageController.jumpToPage(index) here too, if needed
    });
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
