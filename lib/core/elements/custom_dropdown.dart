import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.hintText,
    required this.itemList,
    required this.value,
    required this.onChange,
    this.isFilled,
    this.width,
    this.yValue
  }) : super(key: key);

  final String hintText;
  final List itemList;
  final String value;
  final ValueChanged<String>? onChange;
  final bool? isFilled;
  final double? width;
  final double? yValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
        itemHeight: 40.h,
        dropdownMaxHeight: 150.h,
        dropdownWidth: width ?? 310.w,
        buttonPadding: EdgeInsets.only(left: 10.w),
        isExpanded: true,
        decoration: InputDecoration(
          isDense: true,
            contentPadding: EdgeInsets.only(right: 10.w, top: 12.w, bottom: 12.w,),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightBorder,)
            ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Get.isDarkMode
                  ? AppColors.darkText : AppColors.lightBorder,)
          ),
          filled: isFilled ?? true,
          fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
        ),
        hint: CustomText(
          text: hintText,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        icon: Image.asset(
          AppImages.down,
          height: 20.h,
          width: 20.w,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        offset: Offset(0, yValue ?? -20),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
        ),
        items: itemList.map((e) {
          return DropdownMenuItem(
            value: e,
              child: CustomText(
                  text: e,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              )
          );
        }).toList(),
        onChanged: ( dynamic value) {
          onChange!(value!);
        },
    );
  }
}
