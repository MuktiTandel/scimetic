import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/common_view_screen.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/register_new_account/controller/register_new_account_controller.dart';

class RegisterNewAccountScreen extends StatelessWidget {
    RegisterNewAccountScreen({Key? key}) : super(key: key);

   final controller = Get.put(RegisterNewAccountController());

  @override
  Widget build(BuildContext context) {
    return CommonViewScreen(
      title: AppStrings.rNAccount,
      subTitle: AppStrings.eYCTCNAccount,
      middleWidget: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppStrings.eOrUsername,
              style: TextStyleDecoration.headline1,
            ),
            SizedBox(height: 5.h,),
            SizedBox(
              height: 45.h,
              child: CustomTextField(
                  controller: controller.emailController,
                hintText: AppStrings.eYROUsername,
                onchange: (val) {},
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.cPassword,
              style: TextStyleDecoration.headline1,
            ),
            SizedBox(height: 5.h,),
            SizedBox(
              height: 45.h,
              child: Obx(() => CustomTextField(
                controller: controller.cPasswordController,
                hintText: AppStrings.eYPassword,
                isObscure: !controller.isCPassword.value,
                suffixWidget: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    if ( controller.isCPassword.value == false ) {
                      controller.isCPassword.value = true;
                    } else {
                      controller.isCPassword.value = false;
                    }
                  },
                  child: Padding(
                    padding:  EdgeInsets.all(14.w),
                    child: Image.asset(
                      controller.isCPassword.value == false
                          ? AppImages.unVisible : AppImages.visible,
                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                      fit: BoxFit.fill,
                      height: controller.isCPassword.value == false ? 22.h : 15.h,
                      width: 22.w,
                    ),
                  ),
                ),
                onchange: (val) {},
              )),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.rPassword,
              style: TextStyleDecoration.headline1,
            ),
            SizedBox(height: 5.h,),
            SizedBox(
              height: 45.h,
              child: Obx(() => CustomTextField(
                controller: controller.rPasswordController,
                hintText: AppStrings.eYPassword,
                isObscure: !controller.isRPassword.value,
                suffixWidget: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    if ( controller.isRPassword.value == false ) {
                      controller.isRPassword.value = true;
                    } else {
                      controller.isRPassword.value = false;
                    }
                  },
                  child: Padding(
                    padding:  EdgeInsets.all(14.w),
                    child: Image.asset(
                      controller.isRPassword.value == false
                          ? AppImages.unVisible : AppImages.visible,
                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                      fit: BoxFit.fill,
                      height: controller.isRPassword.value == false ? 22.h : 15.h,
                      width: 22.w,
                    ),
                  ),
                ),
                onchange: (val) {},
              )),
            ),
          ],
        ),
      ),
      bottomWidget: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                AppStrings.aHAccount,
              style: TextStyleDecoration.subTitle,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Get.offNamed(AppPages.LOGIN);
              },
              child: Text(
                  AppStrings.logIn,
                style: TextStyleDecoration.headline2,
              ),
            )
          ],
        ),
      ),
      buttonText: AppStrings.register,
      buttonTap: (){
        Get.offAllNamed(AppPages.HOME);
      },
      isSubtitle: true,
      isEmail: false,
    );
  }
}
