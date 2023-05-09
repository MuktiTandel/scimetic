import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/device_settings/controller/device_settings_controller.dart';

class DeviceSettingsScreen extends StatelessWidget {
   DeviceSettingsScreen({Key? key}) : super(key: key);

   final controller = Get.put(DeviceSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10.h,),
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return commonListView(
                  title: controller.deviceList[index].name,
                  totalDevice: controller.deviceList[index].totalDevices,
                  totalOnline: controller.deviceList[index].totalOnline,
                  totalOffline: controller.deviceList[index].totalOffline
                );
              }
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.only(right: 10.w),
            child: CustomButton(
              height: 30.h,
              width: 85.w,
                onTap: (){},
                buttonText: AppStrings.add,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.add,
                      height: 12.h,
                      width: 12.w,
                    ),
                    SizedBox(width: 10.w,),
                    const Text(
                        AppStrings.add
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget commonListView({ required String title,
    required int totalDevice,
    required int totalOffline, required int totalOnline }) {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: title,
                    fontSize: 13.sp,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  Image.asset(
                    AppImages.sync,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: AppStrings.refresh,
                    fontSize: 12.sp,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10.w,),
                  Image.asset(
                    AppImages.settings,
                    height: 15.h,
                    width: 15.w,
                    color: Get.isDarkMode
                        ? Colors.white : AppColors.subTitleColor,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: AppStrings.settings,
                    fontSize: 12.sp,
                    color: Get.isDarkMode
                        ? Colors.white : AppColors.subTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 5.w,),
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset(
                      AppImages.downArrow,
                      height: 22.h,
                      width: 22.w,
                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.h,),
              CustomText(
                text: '$totalDevice ${AppStrings.devices}',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Image.asset(
                    AppImages.greenEllipse,
                    height: 8.h,
                    width: 8.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: "$totalOnline",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: AppStrings.online,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  SizedBox(width: 15.w,),
                  Image.asset(
                    AppImages.redEllipse,
                    height: 8.h,
                    width: 8.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: "$totalOffline",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: AppStrings.offline,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
