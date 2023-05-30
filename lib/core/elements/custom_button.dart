import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.child,
    this.buttonTextColor
  }) : super(key: key);

  final VoidCallback onTap;
  final String buttonText;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? child;
  final Color? buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 45.h,
        width: width ?? MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10)),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: backgroundColor ?? AppColors.buttonColor
            ),
            child: child ?? SizedBox(
              height: height ?? 50,
              width: Get.width,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontWeight: fontWeight ?? FontWeight.w500,
                      fontSize: fontSize ?? 13.sp,
                    fontFamily: "Poppins",
                    color: buttonTextColor ?? Colors.white
                  ),
                ),
              ),
            ))
    );
  }
}