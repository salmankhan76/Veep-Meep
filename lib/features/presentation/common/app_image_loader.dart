import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../utils/app_colors.dart';

class AppImageLoader extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;

  AppImageLoader({required this.image, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height / 3,
      width: width ?? double.infinity,
      child: Stack(
        children: <Widget>[
          const Center(
            child: SpinKitFadingFour(
              color: AppColors.colorPrimary,
            ),
          ),
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: image,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
