import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/chat/controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key}) : super(key: key);

   final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.chatList.length,
              itemBuilder: (BuildContext context, int index) {
                return listWidget(
                    type: controller.chatList[index].type,
                    profile: controller.chatList[index].profile,
                    name: controller.chatList[index].name,
                    desc: controller.chatList[index].desc,
                    messages: controller.chatList[index].messages,
                  totalMember: controller.chatList[index].members,
                  image2: controller.chatList[index].image2,
                  image1: controller.chatList[index].image1
                );
              }
          )
        ],
      ),
    );
  }

  Widget listWidget({
    required String type,
    required String profile,
    required String name,
    required String desc,
    required int messages,
    required int totalMember,
    required String image1,
    required String image2
  }) {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkBlue : Colors.white,
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              type.contains("chat")
                  ? chatImage(profile: profile)
                  : groupImage(
                  profile: profile,
                  image1: image1,
                  image2: image2,
                  totalMember: totalMember
              ),
              SizedBox(width: 12.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontSize: 14.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: desc,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray,
                  )
                ],
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              Container(
                height: messages.toString().length < 2 ? 18.h : 17.h,
                width: messages.toString().length < 2 ? 20.w : 25.w,
                decoration:  BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            messages.toString().length < 2
                                ? AppImages.redRectangle
                                : AppImages.rectangle,
                        ),
                      fit: BoxFit.fill
                    )
                ),
                child: Center(
                  child:
                  CustomText(
                    text: messages.toString(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  Widget groupImage({
    required String profile,
    required String image1,
    required String image2,
    required int totalMember
  }) {
    return SizedBox(
      height: 40.h,
      width: 50.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 9.h,
                backgroundColor: Colors.transparent,
                child: Image.asset(profile),
              ),
              CircleAvatar(
                maxRadius: 9.h,
                backgroundColor: Colors.transparent,
                child: Image.asset(image1),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 9.h,
                backgroundColor: Colors.transparent,
                child: Image.asset(image2),
              ),
              CircleAvatar(
                maxRadius: 9.h,
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  AppImages.groupEllipse,
                ),
                child: Center(
                  child:
                  CustomText(
                    text: "${totalMember.toString()}+",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget chatImage( {
   required String profile
  }) {
    return SizedBox(
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
                 profile,
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
    );
  }
}
