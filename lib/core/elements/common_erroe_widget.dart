import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget commonErrorWidget({required VoidCallback onTap, required String errorMessage}) {
  return Container(
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.lightRed
        ),
        color: AppColors.lightRed1
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: AppStrings.error,
              color: AppColors.darkRed,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
            Expanded(child: SizedBox(width: 10.w,)),
            GestureDetector(
              onTap: (){
                onTap();
              },
              child: Image.asset(
                AppImages.close1,
                height: 12.h,
                width: 12.w,
              ),
            )
          ],
        ),
        SizedBox(height: 5.h,),
        CustomText(
          text: errorMessage,
          fontSize: 14.sp,
          color: AppColors.subTitleColor,
        )
      ],
    ),
  );
}