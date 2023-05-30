import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget commonImageText({required String image,
  required String title, required Color color}) {

  return Row(
    children: [
      Image.asset(
        image,
        height: 20.h,
        width: 20.w,
        color: color,
      ),
      SizedBox(width: 7.w,),
      CustomText(
        text: title,
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w500,
        color: color,
      )
    ],
  );
}