import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/core/routes/app_routes.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/services/hive_service.dart';
import 'package:hive/hive.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ValueListenableBuilder<Box<AppSettings>>(
        valueListenable: HiveService().getListenableAppSettingsFormBox<AppSettings>(
          box: HiveService().settingBox,
        ),
        builder: (context, Box<AppSettings> box, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,

            theme: (HiveService().getDataFormBox<AppSettings>(box: box).isDark)
                ? ThemeData.dark()
                : ThemeData.light(),
            routerConfig: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
