import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/common_view_screen.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/set_up_new_password/controller/new_password_controller.dart';

class NewPasswordScreen extends StatelessWidget {
   NewPasswordScreen({Key? key}) : super(key: key);

   final controller = Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return CommonViewScreen(
        title: AppStrings.sUNPassword,
        subTitle: AppStrings.sUNPassword,
        middleWidget: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.eNPassword,
                style: TextStyleDecoration.headline1,
              ),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 45.h,
                child: Obx(() => CustomTextField(
                  controller: controller.passwordController,
                  hintText: AppStrings.eYPassword,
                  isObscure: !controller.isPassword.value,
                  suffixWidget: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      if ( controller.isPassword.value == false ) {
                        controller.isPassword.value = true;
                      } else {
                        controller.isPassword.value = false;
                      }
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(14.w),
                      child: Image.asset(
                        controller.isPassword.value == false
                            ? AppImages.unVisible : AppImages.visible,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                        fit: BoxFit.fill,
                        height: controller.isPassword.value == false ? 22.h : 15.h,
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
                AppStrings.rNPassword,
                style: TextStyleDecoration.headline1,
              ),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 45.h,
                child: Obx(() => CustomTextField(
                  controller: controller.repeatPasswordController,
                  hintText: AppStrings.eYPassword,
                  isObscure: !controller.isRepeatPassword.value,
                  suffixWidget: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      if ( controller.isRepeatPassword.value == false ) {
                        controller.isRepeatPassword.value = true;
                      } else {
                        controller.isRepeatPassword.value = false;
                      }
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(14.w),
                      child: Image.asset(
                        controller.isRepeatPassword.value == false
                            ? AppImages.unVisible : AppImages.visible,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                        fit: BoxFit.fill,
                        height: controller.isRepeatPassword.value == false ? 22.h : 15.h,
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
                AppStrings.hAQuestion,
                style: TextStyleDecoration.subTitle,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                },
                child: Text(
                  AppStrings.cSupport,
                  style: TextStyleDecoration.headline2,
                ),
              )
            ],
          ),
        ),
        buttonText: AppStrings.setUP,
        buttonTap: (){
          Get.offAllNamed(AppPages.LOGIN);
        },
        isSubtitle: false,
        isEmail: false
    );
  }
}
