import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/app_extensions.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../domain/entities/message_entity.dart';

class RecieverView extends StatelessWidget {
  final MessageEntity messageEntity;

  RecieverView({required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          messageEntity.img != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.colorBlue,
                    radius: 20,
                    child: CircleAvatar(
                      radius: 18,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(messageEntity.img!))),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    border: Border.all(color: AppColors.colorBlue, width: 1)),
                child: Text(messageEntity.message,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimensions.kFontSize16,
                        color: AppColors.colorBlue)),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  _getDateTime(),
                  style: TextStyle(
                      fontSize: AppDimensions.kFontSize12,
                      color: AppColors.colorGray500,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getDateTime() {
    if (messageEntity.dateTime.isSameDate(DateTime.now())) {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    } else if (messageEntity.dateTime
        .isSameDate(DateTime.now().subtract(const Duration(days: 1)))) {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    } else if (messageEntity.dateTime
        .isBefore(DateTime.now().subtract(const Duration(days: 365)))) {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    } else {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    }
  }
}
