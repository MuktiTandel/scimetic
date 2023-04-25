import 'package:get/get.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/login/binding/login_binding.dart';
import 'package:scimetic/feature/login/view/login_screen.dart';

class AppRoutes {

  static const INITIAL = AppPages.SPLASH;

  static final routes = [
    GetPage(
        name: AppPages.LOGIN,
        page: ()=> LoginScreen(),
      binding: LoginBinding()
    )
  ];

}