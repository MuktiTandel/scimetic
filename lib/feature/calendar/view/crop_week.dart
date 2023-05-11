import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CropWeek extends StatelessWidget {
   const CropWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.w),
          child: CustomText(
              text: DateFormat('MMMM, yyyy').format(DateTime.now()),
            color: AppColors.buttonColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
          ),
        )
      ],
    );
  }
}
