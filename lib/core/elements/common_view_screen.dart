import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/custom_button.dart';

class CommonViewScreen extends StatelessWidget {
  const CommonViewScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.middleWidget,
    required this.bottomWidget,
    required this.buttonText,
    required this.buttonTap,
    required this.isSubtitle,
    required this.isEmail,
    this.email
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Widget middleWidget;
  final Widget bottomWidget;
  final String buttonText;
  final VoidCallback buttonTap;
  final bool isSubtitle;
  final bool isEmail;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Get.isDarkMode
            ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
        body: Padding(
          padding: EdgeInsets.all(13.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 60.h,),
                SvgPicture.asset(
                  Get.isDarkMode ? AppImages.darkLogo : AppImages.lightLogo,
                  height: 30.h,
                  width: 30.w,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  title,
                  style: TextStyleDecoration.headline6,
                ),
                SizedBox(height: 8.h,),
                isSubtitle == true ? Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyleDecoration.subTitle,
                ) : const SizedBox.shrink(),
                isEmail == true ? Text(
                    email ?? "sh**********ab@gmail.com",
                  style: TextStyleDecoration.headline2,
                ) : const SizedBox.shrink(),
                SizedBox(height: 30.h,),
                middleWidget,
                SizedBox(height: 25.h,),
                CustomButton(
                    onTap: (){
                      buttonTap();
                    },
                    buttonText: buttonText
                ),
                SizedBox(height: 15.h,),
                bottomWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
