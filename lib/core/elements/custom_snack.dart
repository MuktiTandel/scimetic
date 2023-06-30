import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showSnack({required String title, required double width}) {
  ScaffoldMessenger.of(Get.context!)
      .showSnackBar( SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        content:  Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 15.sp
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        backgroundColor: Colors.grey.shade200,
        width: width,
    )
  );
}