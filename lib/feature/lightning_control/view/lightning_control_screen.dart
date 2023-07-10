import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_hour_minute_widget.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/lightning_control/controller/lightning_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LightningControlScreen extends StatelessWidget {
  LightningControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(LightningController());

  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: CustomDropDown(
              width: 330.w,
              hintText: dashboardController.selectItem.value,
              itemList: dashboardController.itemList,
              value: dashboardController.selectItem.value,
              onChange: (value) async {
                dashboardController.selectItem.value = value;
                for (var element in dashboardController.mainList) {
                  if (element.identifier!.contains(value)) {
                    controller.storeData.setData(StoreData.id, element.id!);
                    AppConst().debug('select id => ${element.id}');
                  }
                }
                controller.storeData.setData(StoreData.identifier, value);
                AppConst().debug(
                    'select value => ${dashboardController.selectItem.value}');
                for (var element in dashboardController.dataList) {
                  if (element.identifier!.contains(value)) {
                    controller.id.value = element.id!;
                  }
                }
                await controller.getLightningData();
              },
              isEdit: false.obs,
              isEnable: false,
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: AppBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // commonStatusWidget(isOn: controller.isOn),
                    Container(
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15.w, top: 15.w, right: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => controller.isValid.value == true
                                    ? const SizedBox.shrink()
                                    : commonErrorWidget(
                                    onTap: (){
                                      controller.isValid.value = true;
                                    },
                                    errorMessage: controller.errorMessage.value),),
                                Obx(() => controller.isValid.value == false
                                    ? SizedBox(height: 10.h,) : const SizedBox.shrink(),),
                                commonImageText(
                                    image: AppImages.fillSun,
                                    title: AppStrings.dayLightningSettings,
                                    color: AppColors.lightBlue
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                commonHourMinuteWidget(
                                    title1: AppStrings.lightONTime,
                                    hour1: controller.dayLightOnHour,
                                    minute1: controller.dayLightOnMinute,
                                    title2: AppStrings.lightOFFTime,
                                    hour2: controller.dayLightOffHour,
                                    minute2: controller.dayLightOffMinute,
                                ),
                                SizedBox(height: 10.h,),
                                CustomText(
                                  text: AppStrings.lightOutputLevel,
                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                  fontSize: 12.h,
                                ),
                                SizedBox(height: 10.h,),
                                Obx(() =>  CustomText(
                                  text: "${controller.dayLightOutput.round()}%",
                                  color: AppColors.buttonColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ],
                            ),
                          ),
                          slider(selectValue: controller.dayLightOutput),
                          SizedBox(height: 10.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                            child: commonTextField(
                                title: AppStrings.daySpectrum,
                                controller: controller.daySpectrumController,
                                hintText: AppStrings.daySpectrum
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Padding(
                              padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Get.isDarkMode ? AppColors.darkAppbar : AppColors.lightAppbar,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        commonImageText(
                                            image: AppImages.fillMoon,
                                            title: AppStrings.nightLightningSettings,
                                            color: AppColors.lightBlue
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        commonHourMinuteWidget(
                                            title1: AppStrings.lightONTime,
                                            hour1: controller.nightLightOnHour,
                                            minute1: controller.nightLightOnMinute,
                                            title2: AppStrings.lightOFFTime,
                                            hour2: controller.nightLightOffHour,
                                            minute2: controller.nightLightOffMinute,
                                          isField: true
                                        ),
                                        SizedBox(height: 10.h,),
                                        CustomText(
                                          text: AppStrings.lightOutputLevel,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 10.h,),
                                        Obx(() =>  CustomText(
                                          text: "${controller.nightLightOutput.round()}%",
                                          color: AppColors.buttonColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      ],
                                    ),
                                  ),
                                  slider(
                                      selectValue: controller.nightLightOutput
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                                    child: commonTextField(
                                        title: AppStrings.nightSpectrum,
                                        controller: controller.nightSpectrumController,
                                        hintText: AppStrings.nightSpectrum,
                                    ),
                                  ),
                                  SizedBox(height: 15.h,),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.w),
                            child: CustomButton(
                              onTap: () {
                                controller.onSave();
                              },
                              buttonText: AppStrings.save,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 20.h,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget slider({ required RxDouble selectValue}) {
    return Obx(() => Center(
      child: SfSliderTheme(
        data: SfSliderThemeData(
          activeTrackHeight: 6.h,
          inactiveTrackHeight: 6.h,
          activeTrackColor: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightGray2,
          inactiveTrackColor: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightGray2,
          activeLabelStyle: TextStyle(
              color: Get.isDarkMode
                  ? AppColors.darkText : AppColors.lightGray3,
              fontSize: 12.sp,
              fontFamily: "Poppins"
          ),
          inactiveLabelStyle: TextStyle(
              color: Get.isDarkMode
                  ? AppColors.darkText : AppColors.lightGray3,
              fontSize: 12.sp,
              fontFamily: "Poppins"
          ),
          thumbColor: Get.isDarkMode ? AppColors.darkIcon : Colors.white,
          thumbStrokeColor: AppColors.buttonColor,
          thumbStrokeWidth: 2.w,
          overlayColor: AppColors.buttonColor.withOpacity(0.1),
        ),
        child: SizedBox(
          width: Get.width,
          child: SfSlider(
              value: selectValue.value,
              min: 0.0,
              max: 100.0,
              labelFormatterCallback: (dynamic actualValue, String value) {
                return actualValue = "$value%";
              },
              showLabels: true,
              onChanged: (value) {
                selectValue.value = value;
              }
          ),
        ),
      ),
    ));
  }

  Widget commonTextField( {
    required String title,
    required TextEditingController controller,
    required String hintText} ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
          fontSize: 12.h,
        ),
        SizedBox(height: 5.h,),
        SizedBox(
          height: 40.h,
          child: CustomTextField(
            controller: controller,
            borderRadius: 8,
            contentPadding: EdgeInsets.only(left: 10.w),
            hintText: hintText,
            hintTextSize: 12.sp,
            focusBorderColor: AppColors.buttonColor,
            isFilled: Get.isDarkMode ? false : true,
            onchange: (value){},
          ),
        ),
      ],
    );
  }
}
