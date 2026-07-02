import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games/bloc/theme/theme_cubit.dart';
import 'package:games/core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocSelector<ThemeCubit, ThemeState, bool>(
          selector: (state) {
            return state.isDark;
          },
          builder: (context, isDark) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,

              theme: (isDark) ? ThemeData.dark() : ThemeData.light(),
              routerConfig: AppRoutes.routes,
            );
          },
        ),
      ),
    );
  }
}
