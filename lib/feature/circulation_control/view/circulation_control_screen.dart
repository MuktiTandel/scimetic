import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_hour_minute_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/circulation_control/controller/circulation_control_controller.dart';

class CirculationControlScreen extends StatelessWidget {
  CirculationControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(CirculationControlController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Container(
        color: context.theme.cardColor,
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => controller.isValid.value == true
                ? const SizedBox.shrink()
                : commonErrorWidget(
                onTap: (){
                  controller.isValid.value = true;
                },
                errorMessage: controller.errorMessage.value
            )
            ),
            Obx(() => controller.isValid.value == false
                ? SizedBox(height: 10.h,)
                : const SizedBox.shrink()),
            CustomText(
              text: AppStrings.circulationFan,
              fontSize: 15.sp,
              color: AppColors.buttonColor,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 15.h,),
            commonTexField(
                title: AppStrings.temperatureOff,
                controller: controller.temperatureOffController,
                suffixText: "°C",
                  hintText: AppStrings.temperature,
                onChanged: (value) {}
            ),
            SizedBox(height: 10.h,),
            commonTexField(
                title: AppStrings.temperatureOffDeadband,
                controller: controller.temperatureOffDeadbandController,
                suffixText: "°C",
                hintText: AppStrings.temperature,
                onChanged: (value) {}
            ),
            SizedBox(height: 10.h,),
            commonTexField(
                title: AppStrings.humidityON,
                controller: controller.humidityOnController,
                suffixText: "%",
                hintText: AppStrings.humidity,
                onChanged: (value) {}
            ),
            SizedBox(height: 10.h,),
            commonTexField(
                title: AppStrings.humidityONDeadband,
                controller: controller.humidityOnDeadbandController,
                suffixText: "%",
                hintText: AppStrings.humidity,
                onChanged: (value) {}
            ),
            SizedBox(height: 10.h,),
            commonHourMinuteWidget(
                title1: AppStrings.timeON,
                hour1: controller.timeOnHour,
                minute1: controller.timeOnMinute,
                title2: AppStrings.timeOFF,
                hour2: controller.timeOffHour,
                minute2: controller.timeOffMinute
            ),
            SizedBox(height: 20.h,),
            CustomButton(
              onTap: () {
                controller.onSave();
              },
              buttonText: AppStrings.save,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
