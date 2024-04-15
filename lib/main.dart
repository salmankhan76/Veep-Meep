import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veep_meep/app/veep_meep_app.dart';

import '../core/service/dependency_injection.dart' as di;
import 'utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.setupLocator();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.colorPrimary,
    statusBarColor: AppColors.colorPrimary,
  ));

  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) {
        return VeepMeepApp();
      },
    ),
  );
}
