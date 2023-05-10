import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/open_chat/controller/open_chat_controller.dart';

class OpenChatScreen extends StatelessWidget {
   OpenChatScreen({Key? key}) : super(key: key);

   final controller = Get.put(OpenChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? AppColors.darkBlue : Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Image.asset(
                AppImages.backArrow,
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
            ),
          ),
        ),
        leadingWidth: 22.w,
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              height: 35.h,
              width: 42.w,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: 22.h,
                      child: Image.asset(
                        AppImages.group14,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    Get.isDarkMode ? AppImages.darkEllipse : AppImages.ellipse,
                    height: 10.h,
                    width: 10.w,
                  )
                ],
              ),
            ),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.andrewJohnson,
                  fontSize: 16.sp,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: AppStrings.online,
                  fontSize: 12.sp,
                  color: AppColors.buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Image.asset(
                AppImages.search1,
                height: 22.h,
                width: 22.w,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              ),
              SizedBox(width: 5.w,),
              CustomText(
                text: AppStrings.search,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 10.w,)
            ],
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SizedBox(height: 10.h,width: Get.width,)
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1.w,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray2,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 25.h,
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray2,
                ),
                child: Center(
                  child: CustomText(
                      text: AppStrings.today,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightIcon,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Divider(
                  thickness: 1.w,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray2,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: SizedBox(width: 10.w,)),
                      menuImage(),
                      SizedBox(width: 10.w,),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? AppColors.darkBlue3 : Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width : 230.w,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   CustomText(
                                      text: AppStrings.messageDesc,
                                    color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.calender,
                                        height: 15.h,
                                        width: 15.w,
                                        color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                                      ),
                                      SizedBox(width: 10.w,),
                                      CustomText(
                                          text: 'due 12.04.2021',
                                        fontSize: 12.sp,
                                        color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CircleAvatar(
                                        maxRadius: 9.h,
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(AppImages.group14),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            CustomText(
                                text: AppStrings.messageReaded,
                              fontSize: 13.sp,
                              color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: SizedBox(width: 10.w,)),
                      CustomText(
                        text: "19:37",
                        fontSize: 13.sp,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 5.w,),
                      Image.asset(
                        AppImages.doneAll,
                        color: AppColors.buttonColor,
                        height: 18.h,
                        width: 18.w,
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 12.h,
                        child: Image.asset(AppImages.group14),
                      ),
                      SizedBox(width: 10.w,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 230.w,
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode ? AppColors.darkBlue3 : Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: CustomText(
                              text: AppStrings.messageDesc,
                              color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          menuImage()
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  Row(
                    children: [
                      SizedBox(width: 37.w,),
                      CustomText(
                          text: AppStrings.aSecondAgo,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        maxRadius: 12.h,
                        child: Image.asset(AppImages.group14),
                      ),
                      SizedBox(width: 10.w,),
                      Row(
                        children: [
                          CustomText(
                              text: AppStrings.andrewJohnson,
                            fontSize: 14.sp,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                              text: AppStrings.isTyping,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                            fontSize: 14.sp,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
          ),
          SizedBox(height: 60.h,),
        ],
      ),
      bottomSheet: Obx(() => Container(
        height: controller.emojiShowing.value == false ? 55.h : 300.h,
        color: Get.isDarkMode ? AppColors.darkBlue : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightText,
                      controller: controller.messageController,
                      onTap: (){
                        if ( controller.emojiShowing.value == true ) {
                          controller.emojiShowing.value = false;
                        }
                      },
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          color: Get.isDarkMode ? Colors.white : Colors.black
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                          ),
                          border: InputBorder.none,
                          hintText: AppStrings.typeMessageHere,
                          hintStyle: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: "Poppins",
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  GestureDetector(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      controller.emojiShowing.value = !controller.emojiShowing.value;
                    },
                    child: Image.asset(
                      AppImages.smile,
                      height: 22.h,
                      width: 22.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset(
                      AppImages.image,
                      height: 20.h,
                      width: 20.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  GestureDetector(
                    onTap: () async {
                      await controller.selectFile();
                    },
                    child: Image.asset(
                      AppImages.file,
                      height: 15.h,
                      width: 15.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBlack,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset(
                      AppImages.sendFill,
                      height: 28.h,
                      width: 28.w,
                    ),
                  )
                ],
              ),
            ),
            Offstage(
              offstage: !controller.emojiShowing.value,
              child: SizedBox(
                height: 250.h,
                child: EmojiPicker(
                  textEditingController: controller.messageController,
                  config: Config(
                    bgColor: Get.isDarkMode ? AppColors.darkAppbar : AppColors.lightAppbar,
                    iconColorSelected: Get.isDarkMode
                        ? AppColors.darkText : AppColors.lightText,
                    indicatorColor: Get.isDarkMode
                        ? AppColors.darkText : AppColors.lightText,
                    iconColor: Get.isDarkMode
                        ? AppColors.darkIcon : AppColors.lightIcon
                  ),
                ),
              ),
            )
            // SizedBox(height: 5.h,)
          ],
        ),
      )),
    );
  }

  Widget menuImage() {
    return Image.asset(
      AppImages.horizontalMenu,
      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
      height: 20.h,
      width: 20.w,
    );
  }
}
