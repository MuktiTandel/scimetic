import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scimetic/core/const/app_theme.dart';
import 'package:scimetic/core/const/share_preference.dart';
import 'package:scimetic/core/const/theme_service.dart';
import 'package:scimetic/core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharePreferenceService.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.INITIAL,
            getPages: AppRoutes.routes,
            theme: CustomAppTheme.light,
            darkTheme: CustomAppTheme.dark,
            themeMode: ThemeService().theme,
          );
        });
  }
}
