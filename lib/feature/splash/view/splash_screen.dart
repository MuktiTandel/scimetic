import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/core/utils/store_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String email = "";

  StoreData storeData = StoreData();

  @override
  void initState() {
    super.initState();

    email = storeData.getString(StoreData.email) ?? "";

    Future.delayed(const Duration(seconds: 3), () {

      if ( email.isEmpty ) {
        Get.offNamed(AppPages.REGISTERNEWACCOUNT);
      } else {
        Get.offAllNamed(AppPages.HOME);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.lightGreen,
                AppColors.darkGreen,
                ],
              ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    AppImages.appLogo,
                  height: 80.h,
                  width: 80.w,
                ),
                SizedBox(height: 20.h,),
                SvgPicture.asset(
                    AppImages.appTitle,
                  height: 20.h,
                  width: 20.w,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

}
