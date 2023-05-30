import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/common_view_screen.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/login/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return CommonViewScreen(
        title: AppStrings.logIn,
        subTitle: AppStrings.eYCTCYAccount,
        middleWidget: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() => controller.isValid.value == true
                  ? const SizedBox.shrink()
                  : Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.lightRed
                    ),
                    color: AppColors.lightRed1
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.error,
                          color: AppColors.darkRed,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        GestureDetector(
                          onTap: (){
                            controller.isValid.value = true;
                          },
                          child: Image.asset(
                            AppImages.close1,
                            height: 12.h,
                            width: 12.w,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    CustomText(
                      text: controller.errorMessage.value,
                      fontSize: 14.sp,
                      color: AppColors.subTitleColor,
                    )
                  ],
                ),
              ),),
              Obx(() => controller.isValid.value == false
                  ? SizedBox(height: 10.h,) : const SizedBox.shrink(),),
              Text(
                AppStrings.email,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.password,
                    style: TextStyleDecoration.headline1,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Get.toNamed(AppPages.RESETPASSWORD);
                    },
                    child: Text(
                      AppStrings.fPassword,
                      style: TextStyleDecoration.headline2,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 45.h,
                child: Obx(() => CustomTextField(
                  controller: controller.passwordController,
                  hintText: AppStrings.eYPassword,
                  isObscure: !controller.isObscure.value,
                  suffixWidget: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      if ( controller.isObscure.value == false ) {
                        controller.isObscure.value = true;
                      } else {
                        controller.isObscure.value = false;
                      }
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(14.w),
                      child: Image.asset(
                        controller.isObscure.value == false
                            ? AppImages.unVisible : AppImages.visible,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                        fit: BoxFit.fill,
                        height: controller.isObscure.value == false ? 22.h : 15.h,
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
                AppStrings.nOScimetic,
                style: TextStyleDecoration.subTitle,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.offAllNamed(AppPages.REGISTERNEWACCOUNT);
                },
                child: Text(
                  AppStrings.cAnAccount,
                  style: TextStyleDecoration.headline2,
                ),
              )
            ],
          ),
        ),
        buttonText: AppStrings.signIn,
        buttonTap: (){
          controller.userLogin();
        },
      isSubtitle: true,
      isEmail: false,
    );
  }
}
