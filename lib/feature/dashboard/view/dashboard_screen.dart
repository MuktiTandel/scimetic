import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({Key? key}) : super(key: key);

   final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: AppBehavior(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 15.h,),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return listWidget(
                    onTap: (){
                      controller.isOverView.value = true;
                    }
                  );
                }),
            SizedBox(height: 10.h,),
            Padding(
              padding:  EdgeInsets.only(right: 18.w),
              child: CustomButton(
                height: 30.h,
                width: 85.w,
                onTap: (){},
                buttonText: AppStrings.add,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.add,
                        height: 12.h,
                        width: 12.w,
                      ),
                      SizedBox(width: 10.w,),
                      const Text(
                          AppStrings.add
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }

  Widget listWidget({ required VoidCallback onTap}) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
            color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.gWellington,
                      style: TextStyleDecoration.headline5,
                    ),
                    PopupMenuButton<int>(
                      offset: Offset(0, 17.h),
                      padding: EdgeInsets.zero,
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      constraints: BoxConstraints(
                          maxWidth: 115.w,
                          maxHeight: 75.h
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.asset(
                        AppImages.menu,
                        height: 14.h,
                        width: 8.w,
                        color: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightText,
                      ),
                      onSelected: (item) {},
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                            padding: EdgeInsets.zero,
                            value: 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AppImages.edit,
                                        height: 25.h,
                                        width: 25.w,
                                      ),
                                      SizedBox(width: 10.w,),
                                      CustomText(
                                        text: AppStrings.edit,
                                        fontSize: 15.sp,
                                        color: AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      )
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
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 6.h),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.trash,
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                                  SizedBox(width: 10.w,),
                                  CustomText(
                                    text: AppStrings.delete,
                                    fontSize: 15.sp,
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.h,),
                Text(
                  AppStrings.tODesc,
                  style: TextStyleDecoration.body1,
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featureWidget(title: AppStrings.temperature, value: "25° С"),
                        SizedBox(height: 15.h,),
                        featureWidget(title: AppStrings.cO2, value: "600 ppm"),
                      ],
                    ),
                    Expanded(child: SizedBox(width: 10.w,)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featureWidget(title: AppStrings.humidity, value: "75 %"),
                        SizedBox(height: 15.h,),
                        featureWidget(title: AppStrings.vpd, value: "0.95 kPa"),
                      ],
                    ),
                    Expanded(child: SizedBox(width: 10.w,)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h,)
        ],
      ),
    );
  }

  Widget featureWidget({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleDecoration.subHeadline,
        ),
        Text(
          value,
          style: TextStyleDecoration.headline4,
        )
      ],
    );
  }
}
