import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget commonImagePickerWidget({required VoidCallback cameraTap, required VoidCallback galleryTap}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    titlePadding: EdgeInsets.zero,
    title: Center(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 10.w),
            child: CustomText(
              text: AppStrings.selectImages,
              color: AppColors.lightText,
              fontSize: 14.sp,
            ),
          ),
          Divider(
            thickness: 1.w,
            color: AppColors.lightGray3,
          )
        ],
      ),
    ),
    contentPadding: EdgeInsets.all(10.w),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        selectWidget(
            image: AppImages.camera,
            title: AppStrings.camera,
            onTap: (){
              cameraTap();
            }
        ),
        SizedBox(width: 20.w,),
        selectWidget(
            image: AppImages.gallery,
            title: AppStrings.gallery,
            onTap: (){
              galleryTap();
            }
        )
      ],
    ),
  );
}

Widget selectWidget({
  required String image,
  required String title,
  required VoidCallback onTap}) {
  return GestureDetector(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          color: AppColors.subTitleColor,
          radius: const Radius.circular(12),
          dashPattern: const [6, 3, 6, 3],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 60.h,
              width: 70.w,
              color: AppColors.buttonColor.withOpacity(0.1),
              child: Center(
                child: Image.asset(
                  image,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.buttonColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        CustomText(
          text: title,
          fontSize: 13.sp,
          color: AppColors.subTitleColor,
        )
      ],
    ),
    onTap: (){
      onTap();
    },
  );
}