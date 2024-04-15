import 'package:flutter/material.dart';

const kScreenWidthSmall = 320.0;
const kScreenWidthMedium = 360.0;
const kScreenWidthLarge = 414.0;

const kScreenHeightSmall = 568.0;
const kScreenHeightMedium = 667.0;
const kScreenHeightLarge = 812.0;

double kwidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double kheight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
