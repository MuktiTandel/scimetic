import 'package:flutter/material.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';

class TextFieldDecoration {
  static BorderRadius get textBorderRadius => BorderRadius.circular(5);
  static Color get borderColor => Colors.grey;
  static double get borderWidth => 2;

  // Outline border...
  static InputDecorationTheme get getOutLineInputDecoration =>
      InputDecorationTheme(
        filled: true,
        errorMaxLines: 2,
        hintStyle: TextStyleDecoration.textStyle,
        fillColor: Colors.white,
        errorStyle: TextStyle(
          fontFamily: TextStyleDecoration.fontFamily,
          color: Colors.red,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        // focusedErrorBorder: _focusedErrorBorder,
        // errorBorder: _errorBorder,
        // focusedBorder: _focusedBorder,
        // border: _border,
        // enabledBorder: _enabledBorder,
        // disabledBorder: _disabledBorder,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
      );

  // ignore: unused_field
  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );
  // ignore: unused_field
  static final OutlineInputBorder _enabledBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );
  // ignore: unused_field
  static final OutlineInputBorder _disabledBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );
  // ignore: unused_field
  static final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );
  // ignore: unused_field
  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: borderWidth,
    ),
  );
  // ignore: unused_field
  static final OutlineInputBorder _focusedErrorBorder = OutlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: borderWidth,
    ),
  );

  // UnderLine border...

  static InputDecorationTheme get getUnderLineInputDecoration =>
      InputDecorationTheme(
        errorMaxLines: 2,
        // fillColor: Colors.transparent,
        // focusColor: Colors.transparent,
        filled: false,
        fillColor: Colors.red,
        hintStyle: TextStyleDecoration.textFieldPlaceholder,
        labelStyle: TextStyle(
            // color: ColorConstants.emailTextColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400),
        // floatingLabelStyle:
        //     MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        //   print(states);

        // final Color color = states.contains(MaterialState.focused) && !states.contains(MaterialState.error)
        //       ? ColorConstants.checkBoxColor
        //       : states.contains(MaterialState.error)
        //           ? Colors.red
        //           : ColorConstants.blackTextColor;
        //   return TextStyle(
        //           color: ColorConstants.emailTextColor,
        //           fontFamily: FontFamilyString.robotoRegular,
        //           fontWeight: states.contains(MaterialState.error)
        //               ? FontWeight.w500
        //               : FontWeight.w400)
        //       .copyWith(color: color);
        // }),
        errorStyle: TextStyle(
          fontFamily: TextStyleDecoration.fontFamily,
          color: Colors.red,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: _underLineFocusedErrorBorder,
        errorBorder: _underLineErrorBorder,
        focusedBorder: _underLineFocusedBorder,
        border: _underLineBorder,
        enabledBorder: _underLineEnabledBorder,
        disabledBorder: _underLineDisabledBorder,

        // contentPadding: const EdgeInsets.symmetric(
        //   vertical: 10.0,
        //   horizontal: 15.0,
        //), // use to set textfield height...
      );

  static final UnderlineInputBorder _underLineBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );

  static final UnderlineInputBorder _underLineEnabledBorder =
      UnderlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );

  static final UnderlineInputBorder _underLineDisabledBorder =
      UnderlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: borderWidth,
    ),
  );

  static final UnderlineInputBorder _underLineFocusedBorder =
      UnderlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: borderColor,
      width: 3,
    ),
  );

  static final UnderlineInputBorder _underLineErrorBorder =
      UnderlineInputBorder(
    // borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: borderWidth,
    ),
  );

  static final UnderlineInputBorder _underLineFocusedErrorBorder =
      UnderlineInputBorder(
    borderRadius: textBorderRadius,
    borderSide: BorderSide(
      color: Colors.red,
      width: borderWidth,
    ),
  );
}
