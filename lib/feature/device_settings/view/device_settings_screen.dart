import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/device_settings/controller/device_settings_controller.dart';

class DeviceSettingsScreen extends StatelessWidget {
   DeviceSettingsScreen({Key? key}) : super(key: key);

   final controller = Get.put(DeviceSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 10.h,),
              ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return commonListView(
                      title: controller.deviceList[index].name,
                      totalDevice: controller.deviceList[index].totalDevices,
                      totalOnline: controller.deviceList[index].totalOnline,
                      totalOffline: controller.deviceList[index].totalOffline,
                      isSelect: controller.deviceList[index].isSelect
                    );
                  }
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(right: 10.w),
                child: CustomButton(
                  height: 30.h,
                  width: 85.w,
                    onTap: (){
                    Get.dialog(
                      CommonDialogWidget(
                          title: AppStrings.addNewDevice,
                          widget: SizedBox(
                            width: 350.w,
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: AppStrings.id,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightText,
                                  ),
                                  SizedBox(height: 5.h,),
                                  CustomDropDown(
                                      hintText: "123456789101",
                                      itemList: controller.idList,
                                      value: controller.value.value,
                                      onChange: (value){}
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                    text: AppStrings.serialNumber,
                                    fontWeight: FontWeight.w500,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightText,
                                  ),
                                  SizedBox(height: 6.h,),
                                  SizedBox(
                                    height: 38.h,
                                    child: CustomTextField(
                                      controller: controller.serialNumberController,
                                      isFilled: false,
                                      hintText: AppStrings.serialNumber,
                                      borderRadius: 8,
                                      textInputType: TextInputType.number,
                                      contentPadding: EdgeInsets.only(left: 10.w),
                                      suffixWidget: Padding(
                                        padding: EdgeInsets.all(10.w),
                                        child: Image.asset(
                                          AppImages.done,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightText,
                                        ),
                                      ),
                                      onchange: (value){},
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                    text: AppStrings.location,
                                    fontWeight: FontWeight.w500,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightText,
                                  ),
                                  SizedBox(height: 6.h,),
                                  SizedBox(
                                    height: 52.h,
                                    child: TextFormField(
                                      controller: controller.locationController,
                                      cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                      maxLength: 12,
                                      maxLines: null,
                                      style:  TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode ? Colors.white : Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.only(left: 10.w),
                                        hintStyle:  TextStyle(
                                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                            fontSize: 14.sp,
                                            fontFamily: "Poppins"
                                        ),
                                        filled: false,
                                        hintText: AppStrings.location,
                                        counter: const SizedBox.shrink(),
                                        suffixIcon: Obx(() => Padding(
                                          padding:  EdgeInsets.only(top: 8.h,left: 10.w, right: 10.w),
                                          child: CustomText(
                                            text: "${controller.locationLength.value}/12",
                                            fontSize: 14.sp,
                                            color: AppColors.lightIcon,
                                          ),
                                        ))
                                      ),
                                      onChanged: (value) {
                                        controller.locationLength.value = value.length;
                                      },
                                    ),
                                  ),
                                  CustomText(
                                    text: AppStrings.description,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightText,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Container(
                                    height: 100.h,
                                    padding: EdgeInsets.only(left: 10.w, right: 10.w,bottom: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightBorder,
                                        )
                                    ),
                                    child: TextFormField(
                                      controller: controller.descriptionController,
                                      maxLength: 80,
                                      maxLines: 10,
                                      cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                      style:  TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode ? Colors.white : Colors.black,
                                      ),
                                      buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }){
                                        return Obx(() => CustomText(
                                          text: "${controller.descriptionLength}/80",
                                          fontSize: 13.sp,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                        ));
                                      },
                                      decoration: InputDecoration(
                                          hintText: AppStrings.addDescription,
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                              fontSize: 14.sp,
                                              fontFamily: "Poppins"
                                          )
                                      ),
                                      onChanged: (value) {
                                        controller.descriptionLength.value = value.length;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 15.h,),
                                  CustomButton(
                                    height: 40.h,
                                      onTap: (){
                                      controller.descriptionController.clear();
                                      controller.serialNumberController.clear();
                                      controller.locationController.clear();
                                        Get.back();
                                      },
                                      buttonText: AppStrings.save,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 10.h,)
                                ],
                              ),
                            ),
                          )
                      )
                    );
                    },
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commonListView({ required String title,
    required int totalDevice,
    required int totalOffline,
    required int totalOnline,
    required RxBool isSelect,
  }) {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: title,
                    fontSize: 13.sp,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  Image.asset(
                    AppImages.sync,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: AppStrings.refresh,
                    fontSize: 12.sp,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10.w,),
                  Image.asset(
                    AppImages.settings,
                    height: 15.h,
                    width: 15.w,
                    color: Get.isDarkMode
                        ? Colors.white : AppColors.subTitleColor,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: AppStrings.settings,
                    fontSize: 12.sp,
                    color: Get.isDarkMode
                        ? Colors.white : AppColors.subTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 5.w,),
                  Obx(() => GestureDetector(
                    onTap: (){
                      isSelect.value = !isSelect.value;
                    },
                    child: Image.asset(
                      isSelect.value == false
                          ? AppImages.downArrow : AppImages.upArrow,
                      height: 22.h,
                      width: 22.w,
                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                    ),
                  ))
                ],
              ),
              SizedBox(height: 5.h,),
              CustomText(
                text: '$totalDevice ${AppStrings.devices}',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Image.asset(
                    AppImages.greenEllipse,
                    height: 8.h,
                    width: 8.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: "$totalOnline",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: AppStrings.online,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  SizedBox(width: 15.w,),
                  Image.asset(
                    AppImages.redEllipse,
                    height: 8.h,
                    width: 8.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: "$totalOffline",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: AppStrings.offline,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
              Obx(() => isSelect.value == true
                  ? SizedBox(height: 10.h,)
                  : const SizedBox.shrink()),
              Obx(() =>  isSelect.value == true
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return settingWidget();
                  }
              )
                  : const SizedBox.shrink())
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  Widget settingWidget() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.id,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        Text(
                          '2145789',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.darkBlue2,
                              fontFamily: "Poppins",
                              letterSpacing: 1.3.w
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.description_,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        CustomText(
                          text: AppStrings.cO2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Get.isDarkMode
                              ? Colors.white : AppColors.subTitleColor,
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.location_,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        Text(
                          'A1B23',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Get.isDarkMode
                                  ? Colors.white : AppColors.subTitleColor,
                              fontFamily: "Poppins",
                              letterSpacing: 1.3.w
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.state,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.greenEllipse,
                              height: 9.h,
                              width: 9.w,
                            ),
                            SizedBox(width: 5.w,),
                            CustomText(
                              text: AppStrings.online,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: Get.isDarkMode
                                  ? Colors.white : AppColors.subTitleColor,
                            ),
                          ],
                        )
                      ],
                    ),
                    /*SizedBox(height: 10.h,),
                              CustomText(
                                text: "tDMKR4K9CWUFBduY5sygMuh2",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightIcon,
                              )*/
                  ],
                ),
              ),
              Divider(
                thickness: 1.w,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightBorder,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.sensors,
                      height: 25.h,
                      width: 25.w,
                    ),
                    SizedBox(width: 5.w,),
                    CustomText(
                      text: AppStrings.reconnect,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: AppColors.buttonColor,
                    ),
                    SizedBox(width: 10.w,),
                    Image.asset(
                      AppImages.restart,
                      height: 16.h,
                      width: 16.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightGray1,
                    ),
                    SizedBox(width: 5.w,),
                    CustomText(
                      text: AppStrings.restart,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightGray1,
                    ),
                    Expanded(child: SizedBox(width: 10.w,)),
                    Image.asset(
                      AppImages.trash,
                      height: 25.h,
                      width: 25.w,
                    ),
                    SizedBox(width: 5.w,),
                    CustomText(
                      text: AppStrings.delete,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: AppColors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
