import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veep_meep/utils/app_dimensions.dart';
import 'package:veep_meep/utils/app_extensions.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../domain/entities/message_entity.dart';

class SenderView extends StatelessWidget {
  final MessageEntity messageEntity;


  SenderView({required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * .6),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.colorGreen,
                      AppColors.colorBlue,
                    ]),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                border: Border.all(color: AppColors.colorYellow, width: 2)
            ),
            child: Text(messageEntity.message,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppDimensions.kFontSize16,
                    color: AppColors.colorGray50)),
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
    );
  }

  _getDateTime() {
    if (messageEntity.dateTime.isSameDate(DateTime.now())) {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    } else if (messageEntity.dateTime
        .isSameDate(DateTime.now().subtract(const Duration(days: 1)))) {
      return  DateFormat('hh:mm a').format(
          messageEntity.dateTime);
    } else if (messageEntity.dateTime
        .isBefore(DateTime.now().subtract(const Duration(days: 365)))) {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    } else {
      return DateFormat('hh:mm a').format(messageEntity.dateTime);
    }
  }
}
