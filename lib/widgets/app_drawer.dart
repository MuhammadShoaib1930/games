import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/services/hive_service.dart';
import 'package:games/widgets/app_drawer_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          spacing: 5,
          children: [
            SizedBox(
              height: 300.h,
              width: 300.w,
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppDrawerDialog(isImagePicker: true),
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box<AppSettings>(
                          HiveService().settingBoxName,
                        ).listenable(),

                        builder: (context, Box<AppSettings> box, child) {
                          final String path = HiveService()
                              .getAppSettings(box: box)
                              .profileImagePath;
                          return CircleAvatar(
                            backgroundImage: (path.isNotEmpty) ? FileImage(File(path)) : null,
                            backgroundColor: Colors.blue,
                            radius: 95.r,
                            child: path.isEmpty ? const Icon(Icons.person) : null,
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppDrawerDialog(isImagePicker: false),
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: HiveService().getListenableAppSettings(),
                        builder: (context, Box<AppSettings> box, child) {
                          AppSettings appSettings = HiveService().getAppSettings(box: box);
                          return Text(
                            appSettings.userName,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: HiveService().getListenableAppSettings(),
              builder: (context, Box<AppSettings> box, child) {
                bool isDark = HiveService().getAppSettings(box: box).isDark;
                return Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((isDark) ? "Light" : "Dark"),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        HiveService().updateAppSettings(isDark: value);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
