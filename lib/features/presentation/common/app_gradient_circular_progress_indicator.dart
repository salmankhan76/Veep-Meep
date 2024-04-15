import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_mediaQuery.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final double value;
  final Color backgroundColor;
  final List<Color> gradientColors;

  const GradientCircularProgressIndicator({
    super.key,
    this.strokeWidth = 4.0,
    this.value = 0.0,
    this.backgroundColor = Colors.grey,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kwidth(context) * 0.1,
      height: kheight(context) * 0.05,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        value: value,
        backgroundColor: backgroundColor,
        valueColor: ColorTween(
          begin: gradientColors.first,
          end: gradientColors.last,
        ).animate(CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Interval(0.0, value, curve: Curves.linear),
        )),
      ),
    );
  }
}
