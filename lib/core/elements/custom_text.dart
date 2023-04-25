import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.style
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextStyle ? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style ?? TextStyle(
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight,
          fontFamily: 'Poppins',
          color: color,
        decoration: TextDecoration.none
      ),
    );
  }
}