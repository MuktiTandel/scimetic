import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';

class CustomAppTheme {

  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.lightAppbar,
    brightness: Brightness.light,
    textTheme: TextStyleDecoration.getLightTheme,
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
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonColor
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.darkAppbar,
    )
  );
}

/*
const kMessageTextFieldDecoration = InputDecoration.collapsed(
  hintText: 'Type Something...',
  hintStyle: TextStyle(color: Colors.blueGrey),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

Map<int, Color> colorCodes = {
  50: const Color(0xFFFEFBF2),
  100: const Color(0xFFFCF5E0),
  200: const Color(0xFFFBEFCB),
  300: const Color(0xFFF9E9B6),
  400: const Color(0xFFF7E4A6),
  500: const Color(0xFFF6DF96),
  600: const Color(0xFFF5DB8E),
  700: const Color(0xFFF3D783),
  800: const Color(0xFFF2D279),
  900: const Color(0xFFEFCA68),
};

//------------------------------ Material const Color------------------------//

MaterialColor custMaterialBlue = MaterialColor(0xFF828282, colorCodes);
Color custWhite = Colors.white.withOpacity(0.5);
Color custGrey = const Color(0xFF757575);*/
