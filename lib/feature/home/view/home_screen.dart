import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/const/theme_service.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(15.w),
          child: GestureDetector(
            onTap: (){
              controller.openDrawer();
            },
            child: Image.asset(
                AppImages.drawer,
              height: 10.h,
              width: 10.w,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        title: Text(
          AppStrings.tOverview,
          style: TextStyleDecoration.headline6,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){},
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
                      bottom: 13.5,
                      left: 14,
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
            onTap: (){},
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
      body: ScrollConfiguration(
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
                return listWidget();
              }),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(right: 18.w),
                child: CustomButton(
                  height: 35.h,
                    width: 85.w,
                    onTap: (){},
                    buttonText: AppStrings.add,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            AppImages.add,
                          height: 15.h,
                          width: 15.w,
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
      ),
      drawer: Drawer(
        width: 230.w,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 2.w),
          decoration: const BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)
            )
          ) ,
          child: Container(
            decoration:  BoxDecoration(
                color: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ) ,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      Get.isDarkMode ? AppImages.darkLogo : AppImages.lightLogo,
                      height: 35.h,
                      width: 35.w,
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                Divider(
                  color: AppColors.buttonColor,
                  thickness: 2.w,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: AppBehavior(),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isDashboard.value == false ) {
                                    controller.isDashboard.value = true;
                                    controller.isGrowSheet.value = false;
                                    controller.isChat.value = false;
                                    controller.isReport.value = false;
                                    controller.isTodo.value = false;
                                    controller.isCalender.value = false;
                                  }
                                },
                                image: AppImages.dashboard,
                                title: AppStrings.dashboard,
                                isSelect: controller.isDashboard.value,
                              isRightWidget: false
                            ),),
                            SizedBox(height: 5.h,),
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isGrowSheet.value == false ) {
                                    controller.isDashboard.value = false;
                                    controller.isGrowSheet.value = true;
                                    controller.isChat.value = false;
                                    controller.isReport.value = false;
                                    controller.isTodo.value = false;
                                    controller.isCalender.value = false;
                                  }
                                },
                                image: AppImages.growSheets,
                                title: AppStrings.growSheets,
                                isSelect: controller.isGrowSheet.value,
                                isRightWidget: false
                            ),),
                            SizedBox(height: 5.h,),
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isChat.value == false ) {
                                    controller.isDashboard.value = false;
                                    controller.isGrowSheet.value = false;
                                    controller.isChat.value = true;
                                    controller.isReport.value = false;
                                    controller.isTodo.value = false;
                                    controller.isCalender.value = false;
                                  }
                                },
                                image: AppImages.chat,
                                title: AppStrings.chat,
                                isSelect: controller.isChat.value,
                                isRightWidget: true,
                              rightImage: AppImages.redRectangle,
                              rightText: "8"
                            ),),
                            SizedBox(height: 5.h,),
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isReport.value == false ) {
                                    controller.isDashboard.value = false;
                                    controller.isGrowSheet.value = false;
                                    controller.isChat.value = false;
                                    controller.isReport.value = true;
                                    controller.isTodo.value = false;
                                    controller.isCalender.value = false;
                                  }
                                },
                                image: AppImages.reports,
                                title: AppStrings.reports,
                                isSelect: controller.isReport.value,
                                isRightWidget: false
                            ),),
                            SizedBox(height: 5.h,),
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isTodo.value == false ) {
                                    controller.isDashboard.value = false;
                                    controller.isGrowSheet.value = false;
                                    controller.isChat.value = false;
                                    controller.isReport.value = false;
                                    controller.isTodo.value = true;
                                    controller.isCalender.value = false;
                                  }
                                },
                                image: AppImages.toDo,
                                title: AppStrings.toDo,
                                isSelect: controller.isTodo.value,
                                isRightWidget: true,
                              rightImage: AppImages.orangeRectangle,
                              rightText: "12",
                              height: 20.h,
                              width: 20.w
                            ),),
                            SizedBox(height: 5.h,),
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isCalender.value == false ) {
                                    controller.isDashboard.value = false;
                                    controller.isGrowSheet.value = false;
                                    controller.isChat.value = false;
                                    controller.isReport.value = false;
                                    controller.isTodo.value = false;
                                    controller.isCalender.value = true;
                                  }
                                },
                                image: AppImages.calender,
                                title: AppStrings.calendar,
                                isSelect: controller.isCalender.value,
                                isRightWidget: true,
                              rightImage: AppImages.greenRectangle,
                              rightText: "3"
                            ),),
                            SizedBox(height: 10.h,),
                            SizedBox(
                              height: 45.h,
                              width: 226.w,
                              child: Row(
                                children: [
                                  SizedBox(width: 15.w,),
                                  Image.asset(
                                    AppImages.settings,
                                    height: 20.h,
                                    width: 20.w,
                                    color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  CustomText(
                                    text: AppStrings.settings,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                  ),
                                  Expanded(child: SizedBox(width: 10.w,)),
                                  Obx(() => GestureDetector(
                                    onTap: (){
                                      controller.toggle();
                                    },
                                    child: SizedBox(
                                      child: Image.asset(
                                        controller.isSetting.value == false ? AppImages.downArrow : AppImages.upArrow,
                                        height: 25.h,
                                        width: 25.w,
                                        fit: BoxFit.cover,
                                        color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                      ),
                                    ),
                                  ),),
                                  SizedBox(width: 10.w,)
                                ],
                              ),
                            ),
                            Obx(() => controller.isSetting.value == true
                                ? settingWidget() : const SizedBox.shrink()),
                            SizedBox(height: 5.h,),
                            SizedBox(
                              height: 45.h,
                              width: 226.w,
                              child: Row(
                                children: [
                                  SizedBox(width: 15.w,),
                                  Image.asset(
                                    Get.isDarkMode ? AppImages.sun : AppImages.theme,
                                    height: 20.h,
                                    width: 20.w,
                                    color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  CustomText(
                                    text: Get.isDarkMode ? AppStrings.lightMode : AppStrings.darkMode,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                  ),
                                  Expanded(child: SizedBox(width: 10.w,)),
                                  GestureDetector(
                                    onTap: (){
                                      ThemeService().switchTheme();
                                    },
                                    child: SizedBox(
                                      child: SvgPicture.asset(
                                        Get.isDarkMode
                                            ? AppImages.darkUnselectSwitch
                                            : AppImages.lightUnselectSwitch,
                                        height: 25.h,
                                        width: 25.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w,)
                                 /* Obx(() => Switch(value: controller.isLight.value,
                                      onChanged: (value){
                                        controller.toggle();
                                      }))*/
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h,)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listWidget() {
    return Column(
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
                    offset: Offset(0, 16.h),
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
                                padding:  EdgeInsets.all(8.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                        AppImages.edit,
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                        text: AppStrings.edit,
                                      fontSize: 17.sp,
                                      color: AppColors.lightGray1,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.lightGray2,
                                thickness: 1.w,
                              )
                            ],
                          )
                      ),
                      PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.trash,
                                height: 30.h,
                                width: 30.w,
                              ),
                              SizedBox(width: 10.w,),
                              CustomText(
                                text: AppStrings.delete,
                                fontSize: 17.sp,
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                              )
                            ],
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

  Widget drawerWidget ({ required VoidCallback onTap,
    required String image,
    required String title,
    required bool isSelect,
    required bool isRightWidget,
    String? rightImage,
    String? rightText,
    double? height,
    double? width
  }) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        color: isSelect == true
            ? Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar : Colors.transparent,
        height: 45.h,
        width: 226.w,
        child: Row(
          children: [
            SizedBox(width: 15.w,),
            Image.asset(
              image,
              height: 20.h,
              width: 20.w,
              color: isSelect == false
                  ? Get.isDarkMode ? AppColors.white1 : Colors.black : AppColors.buttonColor,
            ),
            SizedBox(
              width: 20.w,
            ),
            CustomText(
              text: title,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: isSelect == false
                  ? Get.isDarkMode ? AppColors.white1 : Colors.black : AppColors.buttonColor,
            ),
            Expanded(child: SizedBox(width: 10.w,)),
            isRightWidget == true ? Container(
              height: height ?? 16.h,
              width: width ?? 16.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(rightImage ?? AppImages.redRectangle)
                )
              ),
              child: Center(
                child: CustomText(
                    text: rightText ?? "1",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ) : const SizedBox.shrink(),
            SizedBox(width: 10.w,)
          ],
        ),
      ),
    );
  }

  Widget settingWidget() {
    return Padding(
      padding:  EdgeInsets.all(12.w),
      child: Column(
        children: [
          settingCommonWidget(
              image: AppImages.deviceSetup,
              title: AppStrings.deviceSetup,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.thermometer,
              title: AppStrings.temperatureControl,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.humidity,
              title: AppStrings.humidityControl,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.cloud,
              title: AppStrings.co2Control,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.sun1,
              title: AppStrings.lightingControl,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.energy,
              title: AppStrings.energyManagement,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.wateringCan,
              title: AppStrings.irrigation,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.fertigation,
              title: AppStrings.fertigation,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.lock,
              title: AppStrings.accessSettings,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.briefcase,
              title: AppStrings.organisationSettings,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.user,
              title: AppStrings.userSetting,
              onTap: (){}
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.notification,
              title: AppStrings.notifications,
              onTap: (){}
          ),
        ],
      ),
    );
  }

  Widget settingCommonWidget ({
    required String image,
    required String title,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Row(
        children: [
          SizedBox(width: 20.w,),
          Image.asset(
            image,
            height: 20.h,
            width: 20.w,
            color: Get.isDarkMode
                ? AppColors.darkIcon : AppColors.lightGray1,
          ),
          SizedBox(width: 10.w,),
          CustomText(
            text: title,
            fontSize: 14.sp,
            color: Get.isDarkMode
                ? AppColors.darkIcon : AppColors.lightGray1,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
