import 'package:get/get.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/authenticate_your_account/binding/authenticate_account_binding.dart';
import 'package:scimetic/feature/authenticate_your_account/view/authenticate_account_screen.dart';
import 'package:scimetic/feature/open_chat/binding/open_chat_binding.dart';
import 'package:scimetic/feature/open_chat/view/open_chat_screen.dart';
import 'package:scimetic/feature/home/binding/home_binding.dart';
import 'package:scimetic/feature/home/view/home_screen.dart';
import 'package:scimetic/feature/login/binding/login_binding.dart';
import 'package:scimetic/feature/login/view/login_screen.dart';
import 'package:scimetic/feature/notification/binding/notification_binding.dart';
import 'package:scimetic/feature/notification/view/notification_screen.dart';
import 'package:scimetic/feature/overview/view/graph_screen.dart';
import 'package:scimetic/feature/register_new_account/binding/register_new_account_binding.dart';
import 'package:scimetic/feature/register_new_account/view/register_new_account_screen.dart';
import 'package:scimetic/feature/reset_password/binding/reset_password_binding.dart';
import 'package:scimetic/feature/reset_password/view/reset_password_screen.dart';
import 'package:scimetic/feature/set_up_new_password/binding/new_password_binding.dart';
import 'package:scimetic/feature/set_up_new_password/view/new_password_screen.dart';
import 'package:scimetic/feature/splash/view/splash_screen.dart';

class AppRoutes {

  static const INITIAL = AppPages.SPLASH;

  static final routes = [
    GetPage(
        name: AppPages.SPLASH,
        page: ()=> const SplashScreen()
    ),
    GetPage(
        name: AppPages.LOGIN,
        page: ()=>  LoginScreen(),
      binding: LoginBinding()
    ),
    GetPage(
        name: AppPages.REGISTERNEWACCOUNT,
        page: ()=> RegisterNewAccountScreen(),
      binding: RegisterNewAccountBinding()
    ),
    GetPage(
        name: AppPages.RESETPASSWORD,
        page: ()=> ResetPasswordScreen(),
      binding: ResetPasswordBinding()
    ),
    GetPage(
        name: AppPages.AUTHENTICATEACOOUNT,
        page: ()=> AuthenticateAccountScreen(),
      binding: AuthenticateAccountBinding()
    ),
    GetPage(
        name: AppPages.NEWPASSWORD,
        page: ()=> NewPasswordScreen(),
      binding: NewPasswordBinding()
    ),
    GetPage(
        name: AppPages.HOME,
        page: ()=> HomeScreen(),
      binding: HomeBinding()
    ),
    GetPage(
        name: AppPages.NOTIFICATION,
        page: ()=> NotificationScreen(),
      binding: NotificationBinding()
    ),
    GetPage(
        name: AppPages.GRAPH,
        page: ()=> GraphScreen()
    ),
    GetPage(
        name: AppPages.OPENCHAT,
        page: ()=> OpenChatScreen(),
      binding: OpenChatBinding()
    ),
  ];

}