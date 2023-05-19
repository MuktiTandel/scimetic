import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CommonDialogWidget extends StatelessWidget {
  const CommonDialogWidget({
    Key? key,
    required this.title,
    required this.widget,
    this.padding,
    required this.onTap
  }) : super(key: key);

  final String title;
  final Widget widget;
  final EdgeInsets? padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 20.h),
      backgroundColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      content: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 6.h, bottom: 6.h),
                  child: Row(
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 14.sp,
                        color: Get.isDarkMode
                            ? AppColors.darkIcon : AppColors.lightGray3,
                        fontWeight: FontWeight.w600,
                      ),
                      Expanded(child: SizedBox(width: 10.w,)),
                      GestureDetector(
                        onTap: (){
                          onTap();
                        },
                        child: Image.asset(
                          AppImages.close,
                          height: 25.h,
                          width: 25.w,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightIcon,
                        ),
                      )
                    ],
                  ),
                ),
                widget,
                SizedBox(height: 5.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
