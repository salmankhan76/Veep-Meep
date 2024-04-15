import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:veep_meep/error/messages.dart';
import 'package:veep_meep/features/data/models/requests/add_uimage_request.dart';
import 'package:veep_meep/features/domain/entities/grid_image_entity.dart';
import 'package:veep_meep/features/presentation/bloc/auth/auth_event.dart';
import 'package:veep_meep/features/presentation/common/app_button.dart';
import 'package:veep_meep/features/presentation/common/appbar.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../core/service/app_permission.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../base_view.dart';

class AddPhotosView extends BaseView {
  @override
  State<AddPhotosView> createState() => _AddPhotosViewState();
}

class _AddPhotosViewState extends BaseViewState<AddPhotosView> {
  var bloc = injection<AuthBloc>();
  String? extension;
  Uint8List? gridImage;
  List<GridImageEntity> gridImageEntities = [];

  @override
  void initState() {
    gridImageEntities.add(GridImageEntity(
      orderId: 0,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 1,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 2,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 3,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 4,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 5,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 6,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 7,
    ));
    gridImageEntities.add(GridImageEntity(
      orderId: 8,
    ));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kIsBizAccount
          ? AppColors.colorYellow
          : AppColors.colorPrimary,
      appBar: VeepMeepAppBar(
        title: 'Add photos',
        backgroundColor: AppConstants.kIsBizAccount
            ? AppColors.colorYellow
            : AppColors.colorPrimary,
      ),
      body: BlocProvider<AuthBloc>(
        create: (_) => bloc,
        child: BlocListener<AuthBloc, BaseState<AuthState>>(
            listener: (_, state) {
              if (state is AddImageSuccessState) {
                appSharedData.setLoginAvailable(true);
                Navigator.pushNamed(context, Routes.kHomeView);
              }
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 104),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 04),
                        height: 88,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*Text(
                                'Hold, drag and drop to',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppDimensions.kFontSize16,
                                    color: AppConstants.kIsBizAccount
                                        ? AppColors.colorBlue
                                        : AppColors.colorGray500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),*/
                              SvgPicture.asset(
                                'images/svg/ic_gallary.svg',
                                color: AppConstants.kIsBizAccount
                                    ? AppColors.colorGreen
                                    : AppColors.colorBlue,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                                  imageQuality: 40,
                                                  maxHeight: 400,
                                                  maxWidth: 400);

                                          CroppedFile? cropped =
                                              await ImageCropper().cropImage(
                                                  sourcePath: photo!.path,
                                                  compressQuality: 60,
                                                  aspectRatio:
                                                      const CropAspectRatio(
                                                          ratioX: 1, ratioY: 1),
                                                  cropStyle:
                                                      CropStyle.rectangle);

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
                                      child: entity.gridImage != null
                                          ? Stack(
                                              children: [
                                                Image.memory(
                                                  entity.gridImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            04),
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
                                                padding:
                                                    const EdgeInsets.all(04),
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
                                                  color:
                                                      AppColors.fontColorWhite,
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
                                if (gridImageEntities.first.gridImage != null) {
                                  bloc.add(
                                    AddImageEvent(
                                      addImageRequest: AddImageRequest(
                                          userId:
                                              appSharedData.getUserId() ?? 0,
                                          data: gridImageEntities),
                                    ),
                                  );
                                } else {
                                  showAppDialog(
                                      title: ErrorMessages.TITLE_ERROR,
                                      message:
                                          'You need to add at least one photo');
                                }
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

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
