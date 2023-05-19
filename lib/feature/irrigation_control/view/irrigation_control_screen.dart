import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_description_textfield.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/common_popup.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/feature/irrigation_control/controller/irrigation_controller.dart';

class IrrigationControlScreen extends StatelessWidget {
  IrrigationControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(IrrigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
              padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  child: CustomTextField(
                    controller: controller.searchController,
                    isFilled: false,
                    borderRadius: 8,
                    hintText: AppStrings.search,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    suffixWidget: Padding(
                      padding:  EdgeInsets.all(13.w),
                      child: Image.asset(
                        AppImages.search,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                      ),
                    ),
                    onchange: (value) {},
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomDropDown(
                  hintText: AppStrings.placeholder,
                  itemList: controller.placeHolderList,
                  value: controller.placeHolderValue.value,
                  isFilled: false,
                  width: 330.w,
                  onChange: (value) {
                    controller.placeHolderValue.value = value;
                  },
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 1,
              shrinkWrap: true,
              itemBuilder: ( BuildContext context, int index ) {
                return listWidget();
              }
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.only(right: 15.w),
            child: CustomButton(
              height: 30.h,
              width: 85.w,
              onTap: (){
                Get.dialog(
                    CommonDialogWidget(
                        title: AppStrings.addNewSchedules,
                        onTap: (){
                          Get.back();
                        },
                        widget: SizedBox(
                          width: 350.w,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImages.fillSun,
                                          height: 20.h,
                                          width: 20.w,
                                          color: AppColors.lightBlue,
                                        ),
                                        SizedBox(width: 10.w,),
                                        CustomText(
                                            text: AppStrings.dayIrrigationMode,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightBlue,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "#1",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22.sp,
                                          color: AppColors.buttonColor,
                                        ),
                                        SizedBox(width: 20.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: AppStrings.timeON,
                                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                              fontSize: 12.h,
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                commonTimeTextField(
                                                    controller: controller.dayTimeOnHourController,
                                                    hintText: AppStrings.hh,
                                                    onChanged: (value){}
                                                ),
                                                SizedBox(width: 5.w,),
                                                CustomText(
                                                  text: ":",
                                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(width: 5.w,),
                                                commonTimeTextField(
                                                    controller: controller.dayTimeOnMinuteController,
                                                    hintText: AppStrings.mm,
                                                    onChanged: (value) {}
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 15.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: AppStrings.timeOFF,
                                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                              fontSize: 12.h,
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                commonTimeTextField(
                                                    controller: controller.dayTimeOffHourController,
                                                    hintText: AppStrings.hh,
                                                    onChanged: (value){}
                                                ),
                                                SizedBox(width: 5.w,),
                                                CustomText(
                                                  text: ":",
                                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(width: 5.w,),
                                                commonTimeTextField(
                                                    controller: controller.dayTimeOffMinuteController,
                                                    hintText: AppStrings.mm,
                                                    onChanged: (value) {}
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Container(
                                color: AppColors.lightAppbar,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 10.h
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImages.fillMoon,
                                          height: 20.h,
                                          width: 20.w,
                                          color: AppColors.lightBlue,
                                        ),
                                        SizedBox(width: 10.w,),
                                        CustomText(
                                          text: AppStrings.nightIrrigationMode,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightBlue,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: "#1",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22.sp,
                                          color: AppColors.buttonColor,
                                        ),
                                        SizedBox(width: 20.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: AppStrings.timeON,
                                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                              fontSize: 12.h,
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                commonTimeTextField(
                                                    controller: controller.nightTimeOnHourController,
                                                    hintText: AppStrings.hh,
                                                    onChanged: (value){}
                                                ),
                                                SizedBox(width: 5.w,),
                                                CustomText(
                                                  text: ":",
                                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(width: 5.w,),
                                                commonTimeTextField(
                                                    controller: controller.nightTimeOnMinuteController,
                                                    hintText: AppStrings.mm,
                                                    onChanged: (value) {}
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 15.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: AppStrings.timeOFF,
                                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                              fontSize: 12.h,
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              children: [
                                                commonTimeTextField(
                                                    controller: controller.nightTimeOffHourController,
                                                    hintText: AppStrings.hh,
                                                    onChanged: (value){}
                                                ),
                                                SizedBox(width: 5.w,),
                                                CustomText(
                                                  text: ":",
                                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(width: 5.w,),
                                                commonTimeTextField(
                                                    controller: controller.nightTimeOffMinuteController,
                                                    hintText: AppStrings.mm,
                                                    onChanged: (value) {}
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.name,
                                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                      fontSize: 12.h,
                                    ),
                                    SizedBox(height: 5.h,),
                                    SizedBox(
                                      height: 40.h,
                                      child: CustomTextField(
                                        controller: controller.nameController,
                                        borderRadius: 8,
                                        contentPadding: EdgeInsets.only(left: 10.w),
                                        hintText: AppStrings.name,
                                        hintTextSize: 12.sp,
                                        focusBorderColor: AppColors.buttonColor,
                                        isFilled: Get.isDarkMode ? true : false,
                                        onchange: (value){},
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    CustomText(
                                      text: AppStrings.tag,
                                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                      fontSize: 12.h,
                                    ),
                                    SizedBox(height: 5.h,),
                                    SizedBox(
                                      height: 40.h,
                                      child: CustomTextField(
                                        controller: controller.tagController,
                                        borderRadius: 8,
                                        contentPadding: EdgeInsets.only(left: 10.w),
                                        hintText: AppStrings.tag,
                                        hintTextSize: 12.sp,
                                        focusBorderColor: AppColors.buttonColor,
                                        isFilled: Get.isDarkMode ? true : false,
                                        onchange: (value){},
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    CustomText(
                                      text: AppStrings.description,
                                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                      fontSize: 12.h,
                                    ),
                                    SizedBox(height: 5.h,),
                                    commonDescriptionTextField(
                                        controller: controller.descriptionController,
                                        descriptionLength: controller.descriptionLength
                                    ),
                                    SizedBox(height: 20.h,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutLineButton(
                                            onTap: (){
                                              Get.back();
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10.w,),
                                        Expanded(
                                          child: CustomButton(
                                            onTap: (){
                                              Get.back();
                                            },
                                            buttonText: AppStrings.save,
                                            width: 100.w,
                                            height: 40.h,
                                            fontSize: 15.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20.h,)
                                  ],
                                )
                              )
                            ],
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
    );
  }

  Widget listWidget() {
    return Container(
      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                text: AppStrings.scheduleName,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              commonPopup(),
              SizedBox(width: 10.w,),
              Obx(() => GestureDetector(
                onTap: (){
                  controller.isSelect.value = !controller.isSelect.value;
                },
                child: Image.asset(
                  controller.isSelect.value == false
                      ? AppImages.downArrow : AppImages.upArrow,
                  height: 22.h,
                  width: 22.w,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                ),
              ))
            ],
          ),
          SizedBox(height: 5.h,),
          Row(
            children: [
              Image.asset(
                AppImages.tag,
                height: 15.h,
                width: 15.w,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              ),
              SizedBox(width: 10.w,),
              CustomText(
                text: AppStrings.seedling,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              )
            ],
          ),
          SizedBox(height: 5.h,),
          Text(
            AppStrings.tODesc,
            style: TextStyleDecoration.body1,
          ),
          Obx(() => controller.isSelect.value == true
              ? SizedBox(height: 10.h,)
              : const SizedBox.shrink()),
          Obx(() => controller.isSelect.value == true ? Row(
            children: [
              Expanded(
                child: commonTimeWidget(title: AppStrings.day),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: commonTimeWidget(title: AppStrings.night),
              ),
            ],
          ) : const SizedBox.shrink()
          )
        ],
      ),
    );
  }

  Widget commonTimeWidget({required String title}) {
    return Container(
      color: Get.isDarkMode ? AppColors.darkAppbar : AppColors.lightAppbar,
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.darkBlue2,
          ),
          SizedBox(height: 10.h,),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 6,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return timeWidget(count: index + 1);
              }
          )
        ],
      ),
    );
  }

  Widget timeWidget({required int count}) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: "#$count",
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 10.w,),
            CustomText(
              text: "07:00 - 07:15",
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 13.sp,
            )
          ],
        ),
        SizedBox(height: 5.h,)
      ],
    );
  }
}
