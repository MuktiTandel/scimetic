import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/common_view_screen.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/elements/otp_textfield.dart';
import 'package:scimetic/feature/authenticate_your_account/controller/authenticate_account_controller.dart';

class AuthenticateAccountScreen extends StatefulWidget {
   AuthenticateAccountScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateAccountScreen> createState() => _AuthenticateAccountScreenState();
}

class _AuthenticateAccountScreenState extends State<AuthenticateAccountScreen> {

   final controller = Get.put(AuthenticateAccountController());


   @override
  void initState() {

     super.initState();

     Future.delayed(const Duration(seconds: 1), (){
       showSnack(
           title: AppStrings.verificationDesc,
           width: 300.w
       );
     });
  }

  @override
  Widget build(BuildContext context) {

    return CommonViewScreen(
        title: AppStrings.aYourAccount,
        subTitle: AppStrings.aYourAccountDesc,
        middleWidget: Center(
          child: OtpTextField(
            focusedBorderColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
            enabledBorderColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
            filled: true,
            fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
            fieldWidth: 47.9.w,
            borderRadius: BorderRadius.circular(10),
            borderWidth: 1.w,
            cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
            textStyle: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontFamily: "Poppins",
              fontSize: 15.sp
            ),
            onSubmit: (val) {
              AppConst().debug('code => $val');
              controller.code.value = int.parse(val);
            },
          ),
        ),
        bottomWidget: SizedBox(
          child: Column(
            children: [
              Text(
                AppStrings.resendNewCodeDesc,
                style: TextStyleDecoration.subTitle,
              ),
              Text(
                AppStrings.hReceived,
                style: TextStyleDecoration.subTitle,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.sendVerificationCode();
                },
                child: Text(
                  AppStrings.rNCode,
                  style: TextStyleDecoration.headline2,
                ),
              ),
            ],
          ),
        ),
        buttonText: AppStrings.confirm,
        buttonTap: () async {
          await controller.verifyAccount();
        },
        isSubtitle: true,
      isEmail: true,
      email: controller.getEmail(),
    );
  }
}
