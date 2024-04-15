import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veep_meep/utils/app_colors.dart';

import '../../../../../utils/app_images.dart';

class ChatTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(2.0),
      height: 40,
      child: Row(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(35.0),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 7,
                    color: AppColors.colorPrimary)
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mood),
                  color: AppColors.colorGray500,
                ),
                SizedBox(
                  width: 150.w,
                  child: const TextField(
                    maxLines: 1,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          color: AppColors.colorGray500,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                const Spacer(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      AppImages.appVeepMeep2,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
