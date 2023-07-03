import 'package:flutter/material.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';

class CustomAppTheme {

  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.lightAppbar,
    brightness: Brightness.light,
    textTheme: TextStyleDecoration.getLightTheme,
    cardColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonColor
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.lightAppbar,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkAppbar,
    textTheme: TextStyleDecoration.getDarkTheme,
    cardColor: AppColors.darkTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonColor
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.darkAppbar,
    )
  );
}
