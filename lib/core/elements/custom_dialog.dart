import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scimetic/core/const/app_colors.dart';

progressDialog(bool isLoading, BuildContext context) {
  AlertDialog dialog = AlertDialog(
    backgroundColor: Colors.white,
    insetPadding: EdgeInsets.symmetric(horizontal: 140.w),
    content: Container(
        height: 40.h,
        width: 50.w,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,
          ),
        )),
    contentPadding: EdgeInsets.all(10.w),
  );
  if (!isLoading) {
    Navigator.of(context, rootNavigator: true).pop();
  } else {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async {
          return true;
        }, child: dialog);
      },
      useRootNavigator: true,
    );
  }
}