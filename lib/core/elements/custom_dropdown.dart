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
    required this.onChange
  }) : super(key: key);

  final String hintText;
  final List<String> itemList;
  final String value;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
        itemHeight: 40.h,
        value: value,
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
        offset: const Offset(0, -20),
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
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              )
          );
        }).toList(),
        onChanged: (value) {
          onChange;
        },
    );
  }
}
