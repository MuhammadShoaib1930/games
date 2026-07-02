import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/bloc/theme/theme_cubit.dart';
import 'package:games/models/app_settings.dart';
import 'package:games/services/hive_service.dart';
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
                        //TODO if user click then show Dialog box where use chose form camera or gallery pick image.

                        // showDialog(context: context, builder: (context) => Dialog());
                      },
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box<AppSettings>(
                          HiveService().settingBoxName,
                        ).listenable(),

                        builder: (context, Box<AppSettings> box, child) {
                          final appSettings = box.get(HiveService().settingBoxName);
                          final String path = appSettings!.profileImagePath;
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
                        //TODO user edit name or add new name so when user click to open dialog box for rewrite name .

                        // showDialog(context: context, builder: (context) => Dialog());
                      },
                      child: Text("name"),
                    ),
                  ],
                ),
              ),
            ),
            BlocSelector<ThemeCubit, ThemeState, bool>(
              selector: (state) {
                return state.isDark;
              },
              builder: (context, isDark) {
                return Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((isDark) ? "Light" : "Dark"),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        HiveService().updateAppSettings(
                          isDark: !HiveService().getAppSettings().isDark,
                        );
                        context.read<ThemeCubit>().themeTogel();
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
