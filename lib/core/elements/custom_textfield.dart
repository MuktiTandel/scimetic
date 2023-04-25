import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.borderRadius,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixWidget,
    this.hintText,
    this.errorText,
    required this.controller,
    this.validator,
    Function(String val)? onchange,
    this.isObscure = false,
    this.focusBorderColor,
    this.cursorColor,
    this.prefixWidget,
    this.maxLine,
    this.autoFocus,
    this.labelPadding,
    this.isType = false,
    this.textAlign,
    this.textAlignVertical,
    this.textInputType,
    this.onTap
  }) :_onchange = onchange,
        super(key: key);

  final double? borderRadius;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Widget? suffixWidget;
  final String? hintText;
  final String? errorText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool? isObscure;
  final Function(String val)? _onchange;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Widget? prefixWidget;
  final int? maxLine;
  final bool? autoFocus;
  final EdgeInsets? labelPadding;
  final bool? isType;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? textInputType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure ?? false,
      cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
      minLines: 1,
      autofocus: autoFocus ?? false,
      maxLines: maxLine ?? 1,
      keyboardType: textInputType ?? TextInputType.text,
      style:  TextStyle(
        fontFamily: "Poppins",
        fontSize: 15.sp,
        color: Get.isDarkMode ? Colors.white : Colors.black
      ),
      onTap: onTap,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            borderSide: BorderSide(
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
            ),
          ),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            borderSide: BorderSide(
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder
            ),
          ),
          fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
          prefixIcon: prefixWidget,
          suffixIcon: suffixWidget,
           hintText: hintText,
          errorText: errorText,
          label: isType == true ? Padding(
            padding: labelPadding ??  EdgeInsets.only(top: 30.h),
            child: CustomText(
              text: hintText ?? "",
            ),
          ) : null,
          hintStyle:  TextStyle(
            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
            fontSize: 12.sp
          )
      ),
      validator: validator,
      onChanged: (val) => _onchange!(val) ?? (val){},
    );
  }
}