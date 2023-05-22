import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/feature/organizations/controller/organization_controller.dart';

class OrganizationScreen extends StatelessWidget {
   OrganizationScreen({Key? key}) : super(key: key);

   final controller = Get.put(OrganizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(15.w),
            child: SizedBox(
              height: 40.h,
              child: CustomTextField(
                controller: controller.searchController,
                isFilled: false,
                borderRadius: 8,
                hintText: AppStrings.search,
                contentPadding: EdgeInsets.only(left: 10.w),
                suffixWidget: Padding(
                  padding:  EdgeInsets.all(13.w),
                  child: Image.asset(
                    AppImages.search,
                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                onchange: (value) {},
              ),
            ),
          ),
          Container(
            color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                        AppImages.organization,
                      height: 18.h,
                      width: 18.w,
                    ),
                    SizedBox(width: 10.w,),
                    CustomText(
                        text: AppStrings.scimetic,
                      fontSize: 14.sp,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonWidget(title: AppStrings.growspaces, count: "19"),
                    commonWidget(title: AppStrings.controllers, count: "19"),
                    commonWidget(title: AppStrings.sensors, count: "0"),
                  ],
                ),
                SizedBox(height: 15.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonWidget(title: AppStrings.admins, count: "2"),
                    commonWidget(title: AppStrings.technicians, count: "2"),
                    SizedBox(width: 10.w,)
                  ],
                ),
                SizedBox(height: 10.h,),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightAppbar,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      CustomText(
                          text: AppStrings.growspaces,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonColor,
                      ),
                      Expanded(child: SizedBox(width: 10.w,)),
                      Image.asset(
                        AppImages.greenEllipse,
                        height: 8.h,
                        width: 8.w,
                      ),
                      SizedBox(width: 5.w,),
                      CustomText(
                        text: "0",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      CustomText(
                        text: AppStrings.online,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
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
                        text: "0",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      CustomText(
                        text: AppStrings.offline,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget commonWidget({required String title, required String count}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: AppColors.subTitleColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: count,
          color: AppColors.buttonColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
