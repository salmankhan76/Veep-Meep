import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/navigation_routes.dart';

class VeepMeepApp extends StatefulWidget {
  @override
  State<VeepMeepApp> createState() => _VeepMeepAppState();
}

class _VeepMeepAppState extends State<VeepMeepApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            title: AppConstants.appName,
            initialRoute: Routes.kSplashView,
            useInheritedMediaQuery: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            onGenerateRoute: Routes.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'SF-Pro',
                primaryColor: AppColors.colorPrimary,
                scaffoldBackgroundColor: AppColors.fontColorWhite),
          );
        });
  }
}
