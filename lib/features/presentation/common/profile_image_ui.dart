import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import 'app_image_loader.dart';

class ProfileImageUI extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? memoryImage;
  final String? name;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;

  ProfileImageUI(
      {this.imageUrl = '',
      this.onEdit,
      this.name,
      this.memoryImage,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkResponse(
                onTap: (){
                  if (onTap != null) onTap!();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: memoryImage != null
                      ? Image.memory(
                          memoryImage!,
                          width: 130,
                          height: 130,
                        )
                      : imageUrl!.isNotEmpty
                          ? AppImageLoader(
                              image: imageUrl!,
                              width: 130,
                              height: 130,
                            )
                          : const CircleAvatar(
                            radius: 42,
                            backgroundColor: AppColors.colorPrimary,
                            child: CircleAvatar(
                              backgroundColor: AppColors.fontColorWhite,
                              radius: 40,
                              child: Icon(
                                Icons.person_add_alt_rounded,
                                color: AppColors.colorPrimary,
                              ),
                            ),
                          ),
                ),
              ),
            ),
            onEdit != null
                ? Positioned(
                    bottom: 30,
                    right: 10,
                    child: InkResponse(
                      onTap: () {
                        if (onEdit != null) onEdit!();
                      },
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.colorPrimary,
                          child: Icon(
                            Icons.edit,
                            color: AppColors.fontColorWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        name != null
            ? Text(
                name!,
                style: const TextStyle(
                    fontSize: 19.34, fontWeight: FontWeight.bold),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
