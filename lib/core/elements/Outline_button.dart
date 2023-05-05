import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';

class OutLineButton extends StatelessWidget {
  const OutLineButton({
    Key? key,
    required this.onTap
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 100.w,
      child: ElevatedButton(
        onPressed: (){
          onTap();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.buttonColor,width: 2.w)
            )
        ),
        child:Center(
          child: Text(
            AppStrings.export,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                fontFamily: "Poppins",
              color: AppColors.buttonColor
            ),
          ),
        ),
      ),
    );
  }
}
