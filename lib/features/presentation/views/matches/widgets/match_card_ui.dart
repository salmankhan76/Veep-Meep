import 'dart:core';

import 'package:flutter/material.dart';
import 'package:veep_meep/features/domain/entities/veep_entity.dart';
import 'package:veep_meep/utils/app_colors.dart';
import 'package:veep_meep/utils/app_utils.dart';

import '../../../../../utils/app_dimensions.dart';

class MatchCardUI extends StatelessWidget {
  final VoidCallback onTapped;
  final VeepEntity veepEntity;

  MatchCardUI({required this.veepEntity, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.colorGray50,
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SizedBox(
                    height: 155,
                    width: double.infinity,
                    child: Image.network(
                      veepEntity.images![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: DateTime.now()
                                    .difference(veepEntity.lastActive!)
                                    .inMinutes <
                                2
                            ? const Color(0xFF64DD17)
                            : AppColors.colorPrimary,
                        radius: 7,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Text(
                    AppUtils.getOnlineStatus(veepEntity.lastActive!),
                    style: TextStyle(
                        color: AppColors.titleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.kFontSize14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
