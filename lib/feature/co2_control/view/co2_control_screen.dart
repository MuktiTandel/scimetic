import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/co2_control/controller/co2_controller.dart';

class Co2ControlScreen extends StatelessWidget {
  Co2ControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(Co2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Obx(() => controller.isGetData.value == true
          ? ScrollConfiguration(
          behavior: AppBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                  child: Column(
                    children: [
                      Obx(
                            () => controller.isValid.value == true
                            ? const SizedBox.shrink()
                            : Padding(
                              padding: EdgeInsets.only(top: 10.h,left: 15.w, right: 15.w),
                              child: commonErrorWidget(
                                  onTap: () {
                                    controller.isValid.value = true;
                                  },
                                  errorMessage:
                                  controller.errorMessage.value
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonImageText(
                                image: AppImages.fillSun,
                                title: AppStrings.dayLightningMode,
                                color: AppColors.lightBlue),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: commonTexField(
                                        title: AppStrings.minimum,
                                        controller: controller.dayMinimumTarget,
                                        suffixText: "ppm",
                                        hintText: AppStrings.cO2,
                                        onChanged: (value) {})),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: commonTexField(
                                        title: AppStrings.maximum,
                                        controller: controller.dayMaximumTarget,
                                        suffixText: "ppm",
                                        hintText: AppStrings.cO2,
                                        onChanged: (value) {})),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppStrings.highCO2Protection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? AppColors.darkText
                                                  : AppColors.lightText,
                                              fontSize: 12.h,
                                              fontFamily: "Poppins"),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                          child: CustomTextField(
                                            controller:
                                            controller.dayHighProtection,
                                            borderRadius: 8,
                                            textInputType: TextInputType.number,
                                            contentPadding:
                                            EdgeInsets.only(left: 10.w),
                                            hintText: AppStrings.cO2,
                                            hintTextSize: 12.sp,
                                            isFilled: Get.isDarkMode ? true : false,
                                            suffixWidget: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.h,
                                                  left: 10.w,
                                                  right: 10.w),
                                              child: CustomText(
                                                text: "ppm",
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : AppColors.subTitleColor,
                                              ),
                                            ),
                                            onchange: (value) {},
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text: AppStrings.switchSelection,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomDropDown(
                                width: 330.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.switchList,
                                value: controller.dayLightningSwitch.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.dayLightningSwitch.value = value;
                                },
                              isEdit: false.obs,
                                ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Obx(
                                  () => CustomDropDown(
                                  width: 330.w,
                                  hintText: AppStrings.chooseRelay,
                                  itemList: controller.dayLightningRelayList,
                                  value: controller.dayLightningRelay.value,
                                  isFilled: true,
                                  onChange: (value) {
                                    controller.dayLightningRelay.value = value;
                                  },
                                    isEdit: false.obs,
                                  ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Get.isDarkMode
                                ? AppColors.darkAppbar
                                : AppColors.lightAppbar,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonImageText(
                                  image: AppImages.fillMoon,
                                  title: AppStrings.nightLightningMode,
                                  color: AppColors.lightBlue),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: commonTexField(
                                          title: AppStrings.minimum,
                                          controller:
                                          controller.nightMinimumTarget,
                                          suffixText: "ppm",
                                          hintText: AppStrings.cO2,
                                          onChanged: (value) {},
                                          isFilled: true)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                      child: commonTexField(
                                          title: AppStrings.maximum,
                                          controller:
                                          controller.nightMaximumTarget,
                                          suffixText: "ppm",
                                          hintText: AppStrings.cO2,
                                          onChanged: (value) {},
                                          isFilled: true)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppStrings.highCO2Protection,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Get.isDarkMode
                                                    ? AppColors.darkText
                                                    : AppColors.lightText,
                                                fontSize: 12.h,
                                                fontFamily: "Poppins"),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            height: 40.h,
                                            child: CustomTextField(
                                              controller:
                                              controller.nightHighProtection,
                                              borderRadius: 8,
                                              textInputType: TextInputType.number,
                                              contentPadding:
                                              EdgeInsets.only(left: 10.w),
                                              hintText: AppStrings.cO2,
                                              hintTextSize: 12.sp,
                                              isFilled: true,
                                              focusBorderColor:
                                              AppColors.buttonColor,
                                              suffixWidget: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.h,
                                                    left: 10.w,
                                                    right: 10.w),
                                                child: CustomText(
                                                  text: "ppm",
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : AppColors.subTitleColor,
                                                ),
                                              ),
                                              onchange: (value) {},
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText(
                                text: AppStrings.switchSelection,
                                color: Get.isDarkMode
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                                fontSize: 12.h,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.switchList,
                                value: controller.nightLightningSwitch.value,
                                onChange: (value) {
                                  controller.nightLightningSwitch.value = value;
                                },
                                isFilled: true,
                                isEdit: false.obs,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText(
                                text: AppStrings.relaySelection,
                                color: Get.isDarkMode
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                                fontSize: 12.h,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Obx(
                                    () => CustomDropDown(
                                    width: 320.w,
                                    hintText: AppStrings.chooseRelay,
                                    itemList:
                                    controller.nightLightningRelayList,
                                    value: controller.nightLightningRelay.value,
                                    isFilled: true,
                                    onChange: (value) {
                                      controller.nightLightningRelay.value =
                                          value;
                                    },
                                      isEdit: false.obs,
                                    ),
                              )
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
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
          : const Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonColor,
        ),
      )),
    );
  }
}
