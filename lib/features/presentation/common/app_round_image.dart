import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../utils/app_colors.dart';

class AppRoundImage extends StatefulWidget {
  final String? image;
  final double radius;
  final String userName;

  AppRoundImage(this.userName, {this.radius = 35, this.image});

  @override
  _AppRoundImageState createState() => _AppRoundImageState();
}

class _AppRoundImageState extends State<AppRoundImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius,
      height: widget.radius,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: AppColors.colorPrimary,
        child: (widget.image != null)
            ? Stack(
                fit: StackFit.expand,
                children: [
                  const Center(
                    child: SpinKitFadingFour(
                      color: AppColors.fontColorWhite,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.radius),
                    ),
                    child: Container(
                      width: widget.radius,
                      height: widget.radius,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: AppColors.colorImagePlaceholder),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.image!,
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Text(
                  widget.userName.substring(0, 2).toUpperCase(),
                  style: const TextStyle(
                      color: AppColors.fontColorWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
