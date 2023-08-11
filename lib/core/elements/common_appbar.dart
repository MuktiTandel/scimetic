import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CommonAppbar extends StatelessWidget {
   CommonAppbar({
    Key? key,
    required this.drawerTap,
    required this.title,
    required this.notificationTap,
    required this.profileTap,
    required this.leadingIcon,
    this.isCalendar = false,
    required this.isPersonal,
    required this.isCrop
  }) : super(key: key);

  final VoidCallback drawerTap;
  final String title;
  final VoidCallback notificationTap;
  final VoidCallback profileTap;
  final String leadingIcon;
  final bool? isCalendar;
   RxBool isPersonal = true.obs;
   RxBool isCrop = false.obs;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      systemOverlayStyle: Get.isDarkMode
          ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      leading: Padding(
        padding:  EdgeInsets.all(14.w),
        child: GestureDetector(
          onTap: (){
            drawerTap();
          },
          child: Image.asset(
            leadingIcon,
            height: 15.h,
            width: 15.w,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyleDecoration.headline6,
          ),
          isCalendar == true ? SizedBox(width: 5.w,) : const SizedBox.shrink(),
          isCalendar == true ? Obx(() => PopupMenuButton<int>(
            offset: Offset(isPersonal.value == true ? 40.w : 68.w, 17.h),
            padding: EdgeInsets.zero,
            color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
            constraints: BoxConstraints(
                maxWidth: 115.w,
                maxHeight: 70.h
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                CustomText(
                  text: isCrop.value == false ? AppStrings.personal : AppStrings.crop,
                  color: AppColors.buttonColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 5.w,),
                Image.asset(
                  AppImages.down,
                  color: AppColors.buttonColor,
                  height: 12.h,
                  width: 12.w,
                )
              ],
            ),
            onSelected: (item) {},
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  padding: EdgeInsets.zero,
                  value: 0,
                  onTap: (){
                    isPersonal.value = true;
                    isCrop.value = false;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 15.w),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w,),
                            CustomText(
                              text: AppStrings.personal,
                              fontSize: 15.sp,
                              color: isPersonal.value == true
                                  ? AppColors.buttonColor
                                  : Get.isDarkMode
                                  ? AppColors.darkText : AppColors.lightGray1,
                              fontWeight: FontWeight.w500,
                            ),
                            isPersonal.value == false
                                ? Expanded(child: SizedBox(width: 10.w,)) : const SizedBox.shrink(),
                            isPersonal.value == false ? Image.asset(
                              AppImages.rightArrow,
                              height: 12.h,
                              width: 12.w,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1,
                            ) : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Divider(
                        color: Get.isDarkMode
                            ? AppColors.darkBlue1
                            : AppColors.lightGray2,
                        thickness: 1.w,
                      )
                    ],
                  )
              ),
              PopupMenuItem<int>(
                  value: 1,
                  padding: EdgeInsets.zero,
                  onTap: (){
                    isPersonal.value = false;
                    isCrop.value = true;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 15.w, bottom: 20.h),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w,),
                        CustomText(
                          text: AppStrings.crop,
                          fontSize: 15.sp,
                          color: isCrop.value == false
                              ? Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1
                              : AppColors.buttonColor,
                          fontWeight: FontWeight.w500,
                        ),
                        isCrop.value == false
                            ? Expanded(child: SizedBox(width: 10.w,)) : const SizedBox.shrink(),
                        isCrop.value == false ? Image.asset(
                          AppImages.rightArrow,
                          height: 12.h,
                          width: 12.w,
                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1,
                        ) : const SizedBox.shrink(),
                      ],
                    ),
                  )
              ),
            ],
          )) : const SizedBox.shrink(),
        ],
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
