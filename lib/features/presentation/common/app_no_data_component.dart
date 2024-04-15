import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_animations.dart';
import '../../../utils/app_constants.dart';

class NoDataUI extends StatelessWidget {
  final String? message;
  final String animationPath;

  NoDataUI({this.message, this.animationPath = AppAnimations.animationNoData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(animationPath,
            height: 250, width: 250, alignment: Alignment.center),
        (message != null && message!.isNotEmpty)
            ? Padding(
                padding: EdgeInsets.all(AppConstants.UI_PADDING),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
