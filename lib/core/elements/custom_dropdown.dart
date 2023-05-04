import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.hintText
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        itemHeight: 40.h,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(13.w),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightBorder,)
            )
        ),
        hint: CustomText(
          text: hintText,
          fontSize: 14.sp,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        icon: Image.asset(
          AppImages.down,
          height: 20.h,
          width: 20.w,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        items: [],
        onChanged: (value) {}
    );
  }
}
