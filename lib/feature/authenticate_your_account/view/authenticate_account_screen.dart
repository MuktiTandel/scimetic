import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/common_view_screen.dart';
import 'package:scimetic/core/routes/app_pages.dart';

class AuthenticateAccountScreen extends StatelessWidget {
  const AuthenticateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonViewScreen(
        title: AppStrings.aYourAccount,
        subTitle: AppStrings.aYourAccountDesc,
        middleWidget: SizedBox(),
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
              Text(
                AppStrings.rNCode,
                style: TextStyleDecoration.headline2,
              ),
            ],
          ),
        ),
        buttonText: AppStrings.confirm,
        buttonTap: (){
           Get.toNamed(AppPages.NEWPASSWORD);
        },
        isSubtitle: true,
      isEmail: true,
    );
  }
}
