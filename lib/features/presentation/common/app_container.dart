import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_constants.dart';
import '../../../utils/app_colors.dart';

class AppContainer extends StatefulWidget {
  Widget child;
  Color? containerColor;
  Color? borderColor;

  AppContainer({
    Key? key,
    required this.child,
    this.containerColor = AppColors.colorGray50,
    this.borderColor = AppColors.colorBorder,
  }) : super(key: key);

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.borderColor??(AppConstants.kIsBizAccount
                ? AppColors.colorGreen
                : AppColors.colorBorder),
            width: 1,
          )),
      child: widget.child,
    );
  }
}
