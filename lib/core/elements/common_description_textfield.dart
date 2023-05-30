import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';

Widget commonDescriptionTextField({
  required TextEditingController controller,
  required RxInt descriptionLength
}) {
  return Obx(() => SizedBox(
      height: 100.h,
      child: TextFormField(
        controller: controller,
        maxLength: 80,
        maxLines: 50,
        cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        style:  TextStyle(
            fontFamily: "Poppins",
            fontSize: 15.sp,
            color: Get.isDarkMode ? Colors.white : Colors.black
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: AppColors.buttonColor
            ),
          ),
          hintText: AppStrings.addDescription,
          contentPadding: EdgeInsets.all(10.w),
          hintStyle:  TextStyle(
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 14.sp,
              fontFamily: "Poppins"
          ),
          counterText: "${descriptionLength.value}/80",
          counterStyle: TextStyle(
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"
          ),
        ),
        onChanged: (value){
          descriptionLength.value = value.length;
        },
      )
  ));
}