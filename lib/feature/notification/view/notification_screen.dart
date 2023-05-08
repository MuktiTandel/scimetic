import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/notification/controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);

   final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 40.h),
          child: AppBar(
            systemOverlayStyle: Get.isDarkMode
                ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            leading: Padding(
              padding:  EdgeInsets.all(13.w),
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Image.asset(
                  AppImages.backArrow,
                  height: 15.h,
                  width: 15.w,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            title: Text(
              AppStrings.notification,
              style: TextStyleDecoration.headline6,
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: (){
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
          ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return messageWidget(
                  image: controller.messageList[index].image,
                  name: controller.messageList[index].name,
                  time: controller.messageList[index].time
                );
              }
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return groupWidget();
              }
          ),
        ],
      ),
    );
  }

  Widget messageWidget ( {
    required String image,
    required String name,
    required int time }) {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkBlue : Colors.white,
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              SizedBox(
                height: 40.h,
                width: 55.w,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        maxRadius: 22.h,
                        child: Image.asset(
                            image
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      Get.isDarkMode ? AppImages.darkEllipse : AppImages.ellipse,
                      height: 13.h,
                      width: 13.w,
                    )
                  ],
                ),
              ),
              SizedBox(width: 8.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  Row(
                      children: [
                        CustomText(
                          text: AppStrings.sentYouA,
                          fontSize: 13.sp,
                          color: Get.isDarkMode
                              ? AppColors.darkText : AppColors.lightGray1,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          text: AppStrings.message,
                          fontSize: 13.sp,
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.w400,
                        )
                      ]
                  )
                ],
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              CustomText(
                text: "$time${AppStrings.h}",
                fontSize: 14.sp,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightIcon,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  Widget groupWidget() {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkBlue : Colors.white,
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 108.w,
                    child: Stack(
                      children: [
                        groupImage(image: AppImages.group1),
                        Positioned(
                            left: 14.w,
                            child: groupImage(image: AppImages.group2)
                        ),
                        Positioned(
                            left: 28.w,
                            child: groupImage(image: AppImages.group3)
                        ),
                        Positioned(
                            left: 42.w,
                            child: groupImage(image: AppImages.group4)
                        ),
                        Positioned(
                            left: 56.w,
                            child: groupImage(image: AppImages.group5)
                        ),
                        Positioned(
                            left: 70.w,
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.groupEllipse)
                                  )
                              ),
                              child: Center(
                                child:
                                CustomText(
                                  text: '5+',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: CustomText(
                      text: AppStrings.workGroupChat,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  CustomText(
                    text: "1${AppStrings.h}",
                    fontSize: 14.sp,
                    color: Get.isDarkMode
                        ? AppColors.darkText : AppColors.lightIcon,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  CustomText(
                    text: "12 ${AppStrings.new_}",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttonColor,
                  ),
                  CustomText(
                    text: AppStrings.messages,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode
                        ? AppColors.darkText : AppColors.lightGray1,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  Widget groupImage ({ required String image }) {
    return Image.asset(
      image,
      height: 30.h,
      width: 30.w,
    );
  }
}
