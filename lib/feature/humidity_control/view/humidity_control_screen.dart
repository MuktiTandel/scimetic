import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_status_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/feature/humidity_control/controller/humidity_controller.dart';

class HumidityControlScreen extends StatelessWidget {
   HumidityControlScreen({Key? key}) : super(key: key);

   final controller = Get.put(HumidityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          commonStatusWidget(isOn: controller.isOn),
          SizedBox(height: 10.h,),
          Container(
            color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
            child: Padding(
              padding:  EdgeInsets.all(15.w),
              child: Column(
                children: [
                  commonImageText(
                      image: AppImages.fillSun,
                      title: AppStrings.dayHumidityMode,
                      color: AppColors.lightBlue
                  ),
                  SizedBox(height: 10.h,),
                  commonTexField(
                      title: AppStrings.setTargetRelativeHumidity,
                      controller: controller.dayHumidityTarget,
                      suffixText: "%",
                      hintText: AppStrings.rH,
                      onChanged: (value) {},
                    contentPadding: 20.w
                  ),
                  SizedBox(height: 10.h,),
                  commonTexField(
                      title: AppStrings.deadband,
                      controller: controller.dayHumidityDeadband,
                      suffixText: "%",
                      hintText: AppStrings.rH,
                      onChanged: (value){}
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
