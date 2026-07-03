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
                        valueListenable: HiveService().getListenableAppSettingsFormBox<AppSettings>(
                          box: HiveService().settingBox,
                        ),

                        builder: (context, Box<AppSettings> box, child) {
                          final String path = HiveService()
                              .getDataFormBox<AppSettings>(box: box)
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
                        valueListenable: HiveService().getListenableAppSettingsFormBox<AppSettings>(
                          box: HiveService().settingBox,
                        ),
                        builder: (context, Box<AppSettings> box, child) {
                          AppSettings appSettings = HiveService().getDataFormBox<AppSettings>(
                            box: box,
                          );
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
              valueListenable: HiveService().getListenableAppSettingsFormBox<AppSettings>(
                box: HiveService().settingBox,
              ),
              builder: (context, Box<AppSettings> box, child) {
                bool isDark = HiveService().getDataFormBox<AppSettings>(box: box).isDark;
                return Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((isDark) ? "Light" : "Dark"),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        HiveService().updateBoxData<AppSettings>(
                          box: HiveService().settingBox,
                          isDark: value,
                        );
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
