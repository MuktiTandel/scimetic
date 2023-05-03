import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({
    Key? key,
    required this.drawerTap,
    required this.title,
    required this.notificationTap,
    required this.profileTap,
    required this.leadingIcon
  }) : super(key: key);

  final VoidCallback drawerTap;
  final String title;
  final VoidCallback notificationTap;
  final VoidCallback profileTap;
  final String leadingIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: Get.isDarkMode
          ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      leading: Padding(
        padding:  EdgeInsets.all(15.w),
        child: GestureDetector(
          onTap: (){
            drawerTap();
          },
          child: Image.asset(
            leadingIcon,
            height: 10.h,
            width: 10.w,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyleDecoration.headline6,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
            onTap: (){
              notificationTap();
            },
            child: Center(
              child: SizedBox(
                height: 26.5.h,
                width: 30.w,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      AppImages.notification,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      height: 20.h,
                      width: 20.w,
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 14.w,
                      child: Container(
                        height: 16.h,
                        width: 16.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AppImages.rectangle,),
                            )
                        ),
                        child: Center(
                          child: CustomText(
                            text: "23",
                            fontSize: 5.5.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: (){
            profileTap();
          },
          child: CircleAvatar(
            maxRadius: 12.h,
            child: Image.asset(
              AppImages.profile,
            ),
          ),
        ),
        SizedBox(width: 15.w,)
      ],
    );
  }
}
