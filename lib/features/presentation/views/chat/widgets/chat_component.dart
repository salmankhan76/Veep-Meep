import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veep_meep/utils/app_colors.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/app_extensions.dart';
import 'package:veep_meep/utils/app_images.dart';

import '../../../../domain/entities/contacts_entity.dart';

class ChatComponent extends StatelessWidget {
  final VoidCallback tap;
  final ContactEntity contactEntity;

  ChatComponent({
    required this.contactEntity,
    required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        // height: 60.h,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xffE6E6E6),
                      radius: 20,
                      child: CircleAvatar(
                        radius: 20,
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipOval(
                              child: contactEntity.img == ""
                                  ? Image.asset(AppImages.appLogo)
                                  : Image.network(
                                      fit: BoxFit.fill,
                                      contactEntity.img,
                                    ),
                            )),
                      ),
                    ),
                    contactEntity.isOnline
                        ? const Positioned(
                            top: 25,
                            left: 28,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.colorGray50,
                              child: CircleAvatar(
                                radius: 3,
                                backgroundColor: AppColors.colorGreen,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ]),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contactEntity.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppDimensions.kFontSize16,
                              color: AppColors.colorGray800),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        contactEntity.last_message["content"] == null &&
                                contactEntity.last_message["readAt"] == null
                            ? Text("Say hi to start the conversation",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppDimensions.kFontSize16,
                                    color: AppColors.colorGray600))
                            : Text(
                                contactEntity.last_message["content"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight:
                                        contactEntity.last_message["readAt"] ==
                                                null
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                    fontSize: AppDimensions.kFontSize16,
                                    color:
                                        contactEntity.last_message["readAt"] ==
                                                null
                                            ? Colors.black
                                            : AppColors.colorGray600),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  contactEntity.isNotSeen
                      ? Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.circle_rounded,
                            color: AppColors.colorBlue.withOpacity(0.7),
                            size: 8,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 5,
                  ),
                  contactEntity.last_message == {}
                      ? const Text("")
                      : Text(
                          _getDateTime() ?? _getDateVeepedTime(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppDimensions.kFontSize12,
                              color: AppColors.colorGray600),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String? _getDateTime() {
    if (contactEntity != null &&
        contactEntity.last_message != {} &&
        contactEntity.last_message != null &&
        contactEntity.last_message!.isNotEmpty) {
      final createdDateTime = DateTime.tryParse(
        contactEntity.last_message!["created_at"] ?? "",
      );
      if (createdDateTime != null) {
        if (createdDateTime.isSameDate(DateTime.now())) {
          return DateFormat('hh:mm a').format(createdDateTime);
        } else if (createdDateTime
            .isSameDate(DateTime.now().subtract(const Duration(days: 1)))) {
          return 'Yesterday';
        } else if (createdDateTime
            .isBefore(DateTime.now().subtract(const Duration(days: 365)))) {
          return DateFormat('yyyy MMM').format(createdDateTime);
        } else {
          return DateFormat('MMM dd').format(createdDateTime);
        }
      }
    }
    return null; // Return null if any of the required values is null or empty
  }

  _getDateVeepedTime() {
    if (contactEntity.order_by.isSameDate(DateTime.now())) {
      return DateFormat('hh:mm a').format(contactEntity.order_by);
    } else if (contactEntity.order_by
        .isSameDate(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else if (contactEntity.order_by
        .isBefore(DateTime.now().subtract(const Duration(days: 365)))) {
      return DateFormat('yyyy MMM').format(contactEntity.order_by);
    } else {
      return DateFormat('MMM dd').format(contactEntity.order_by);
    }
  }
}
