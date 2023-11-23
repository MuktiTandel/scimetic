import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget editDeletePopup(
    {required VoidCallback editTap, required VoidCallback deleteTap}) {
  return PopupMenuButton<int>(
    offset: Offset(0, 17.h),
    padding: EdgeInsets.zero,
    color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
    constraints: BoxConstraints(maxWidth: 115.w, maxHeight: 100.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Image.asset(
      AppImages.menu,
      height: 14.h,
      width: 8.w,
      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
    ),
    onSelected: (item) {},
    itemBuilder: (context) => [
      PopupMenuItem<int>(
          padding: EdgeInsets.zero,
          value: 0,
          onTap: () {
            editTap();
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 3),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.edit,
                      height: 25.h,
                      width: 25.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText
                          : AppColors.lightGray1,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: AppStrings.edit,
                      fontSize: 15.sp,
                      color: Get.isDarkMode
                          ? AppColors.darkText
                          : AppColors.lightGray1,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              Divider(
                height: 5,
                color:
                    Get.isDarkMode ? AppColors.darkBlue1 : AppColors.lightGray2,
                thickness: 1.w,
              )
            ],
          )),
      PopupMenuItem<int>(
          value: 1,
          padding: EdgeInsets.zero,
          onTap: () {
            deleteTap();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Row(
              children: [
                Image.asset(
                  AppImages.trash,
                  height: 25.h,
                  width: 25.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CustomText(
                  text: AppStrings.delete,
                  fontSize: 15.sp,
                  color: AppColors.red,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          )),
    ],
  );
}
