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
import 'package:scimetic/feature/reset_password/controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({Key? key}) : super(key: key);

   final controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return CommonViewScreen(
        title: AppStrings.resetPassword,
        subTitle: AppStrings.resetDesc,
        middleWidget: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  focusBorderColor: AppColors.buttonColor,
                  onchange: (val) {},
                ),
              ),
            ],
          ),
        ),
        bottomWidget: SizedBox(
          child: Column(
            children: [
              Row(
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
              SizedBox(height: 20.h,),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.offAllNamed(AppPages.LOGIN);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        AppImages.leftArrow,
                      height: 10.h,
                      width: 10.w,
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                        AppStrings.bToLogin,
                      style: TextStyleDecoration.headline3,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        buttonText: AppStrings.continue_,
        buttonTap: (){
          Get.toNamed(AppPages.AUTHENTICATEACOOUNT,
              arguments: {"email" : controller.emailController.value.text});
        },
      isSubtitle: true,
      isEmail: false,
    );
  }
}
