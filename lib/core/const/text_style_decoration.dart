import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';

class TextStyleDecoration {
  // App Default font...
  static String? fontFamily="Poppins";

  // Get Text theme...
  static TextTheme get getLightTheme => TextTheme(
        labelSmall: _overLine,
        bodySmall: _caption,
        bodyLarge: body1,
        bodyMedium: _body2,
        displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineMedium: headline4,
        headlineSmall: headline5,
        titleLarge: headline6,
        titleMedium: subTitle,
        titleSmall: subHeadline,
        labelLarge: _button,
      );

  // Get Text theme...
  static TextTheme get getDarkTheme => TextTheme(
        labelSmall: _overLine,
        bodySmall: _caption,
        bodyLarge: body1,
        bodyMedium: _body2,
        displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineMedium: headline4,
        headlineSmall: headline5,
        titleLarge: headline6,
        titleMedium: subTitle,
        titleSmall: subHeadline,
        labelLarge: _button,
      );

  static TextStyle get textFieldPlaceholder => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        fontSize: 14.0,
      );

  static TextStyle get textStyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        fontSize: 14.0,
      );

  static TextStyle get textUnderLine => TextStyle(
        decoration: TextDecoration.underline,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        fontSize: 16.0,
      );

  static TextStyle get _overLine => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get _caption => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 12.0,
    
  );

  static TextStyle get body1 => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400
  );

  static TextStyle get _body2 => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get headline1 => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
    fontSize: 12.sp,
    // fontWeight: FontWeight.w400,
  );

  static TextStyle get headline2 => TextStyle(
    fontFamily: fontFamily,
    color: AppColors.buttonColor,
    fontSize: 11.5.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get headline3 => TextStyle(
    fontFamily: fontFamily,
    color: AppColors.red,
    fontSize: 11.5.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get headline4 => TextStyle(
    fontFamily: fontFamily,
    color: AppColors.buttonColor,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get headline5 => TextStyle(
    fontFamily: fontFamily,
    color: AppColors.buttonColor,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get headline6 => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get subTitle => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
    fontSize: 11.5.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get subHeadline => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? AppColors.darkIcon : Colors.black,
    fontSize: 11.5.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get _button => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
}


