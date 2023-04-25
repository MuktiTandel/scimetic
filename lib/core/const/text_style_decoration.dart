import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';

class TextStyleDecoration {
  // App Default font...
  static String? fontFamily="Poppins";

  // Get Text theme...
  static TextTheme get getLightTheme => TextTheme(
        labelSmall: _overLine, // 10.0
        bodySmall: _caption, // 12.0
        bodyLarge: _body1, // 14.0
        bodyMedium: _body2, // 16.0
        displayLarge: headline1, // 18.0
        displayMedium: headline2, // 21.0
        displaySmall: headline3, // 22.0
        headlineMedium: _headline4, // 24.0
        headlineSmall: _headline5, // 26.0
        titleLarge: headline6, // 28.0
        titleMedium: subTitle, // 14.0 this is also used when no style is given to textField..
        titleSmall: _subHeadline, // 16.0
        labelLarge: _button, // 16.0
      );

  // Get Text theme...
  static TextTheme get getDarkTheme => TextTheme(
        labelSmall: _overLine, // 10.0
        bodySmall: _caption, // 12.0
        bodyLarge: _body1, // 14.0
        bodyMedium: _body2, // 16.0
        displayLarge: headline1, // 18.0
        displayMedium: headline2, // 21.0
        displaySmall: headline3, // 22.0
        headlineMedium: _headline4, // 24.0
        headlineSmall: _headline5, // 26.0
        titleLarge: headline6, // 28.0
        titleMedium:
            subTitle, // 14.0 this is also used when no style is given to textfield..
        titleSmall: _subHeadline, // 16.0
        labelLarge: _button, // 16.0
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

  static TextStyle get _body1 => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 14.0,
   
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

  static TextStyle get _headline4 => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get _headline5 => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 26.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get headline6 => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get subTitle => TextStyle(
    fontFamily: fontFamily,
    color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
    fontSize: 11.5.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get _subHeadline => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get _button => TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
}


