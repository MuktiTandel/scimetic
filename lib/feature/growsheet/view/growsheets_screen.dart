import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/growsheet/controller/growsheets_controller.dart';

class GrowSheetsScreen extends StatelessWidget {
   GrowSheetsScreen({Key? key}) : super(key: key);

   final controller = Get.put(GrowSheetController());

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
              Padding(
                padding:  EdgeInsets.all(15.w),
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
                      onChange: (value) {
                          controller.placeHolderValue.value = value;
                      },
                    )
                  ],
                ),
              ),
              /*Obx(() => controller.isGetData.value == false ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
              ) : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.growSheetDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return listWidget();
                  }
              ),),*/
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return listWidget();
                  }
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(right: 18.w),
                child: CustomButton(
                  height: 30.h,
                  width: 85.w,
                  onTap: (){
                    Get.dialog(
                      CommonDialogWidget(
                          title: AppStrings.addNewGrowsheet,
                          padding: EdgeInsets.zero,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 15.w, right: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.strainName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    SizedBox(height: 5.h,),
                                    CustomDropDown(
                                        hintText: AppStrings.chooseStrain,
                                      itemList: controller.strainNameList,
                                      value: controller.strainValue.value,
                                      onChange: (value) {
                                        controller.strainValue.value = value;
                                      },
                                    ),
                                    SizedBox(height: 10.h,),
                                    CustomText(
                                      text: AppStrings.seedBank1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    SizedBox(height: 5.h,),
                                    CustomDropDown(
                                        hintText: AppStrings.chooseSeedBank,
                                      itemList: controller.seedBankList,
                                      value: controller.seedBankValue.value,
                                      onChange: (value) {
                                        controller.seedBankValue.value = value;
                                      },
                                    ),
                                    SizedBox(height: 10.h,),
                                    CustomText(
                                      text: AppStrings.tag,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    SizedBox(height: 5.h,),
                                    CustomDropDown(
                                        hintText: AppStrings.chooseTag,
                                      itemList: controller.tagList,
                                      value: controller.tagValue.value,
                                      onChange: (value) {
                                        controller.tagValue.value = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Divider(
                                thickness: 1.w,
                                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            AppImages.fillSun,
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                        SizedBox(width: 10.w,),
                                        CustomText(
                                            text: AppStrings.dayMode,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightBlue,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        targetWidget(
                                            title: AppStrings.targetC,
                                            suffixText: "°C",
                                            hintText: AppStrings.t,
                                            controller: controller.dayTemperatureController,
                                        ),
                                        SizedBox(width: 10.w,),
                                        targetWidget(
                                            title: AppStrings.targetRH,
                                            suffixText: "%",
                                            hintText: AppStrings.rH,
                                            controller: controller.dayRhController
                                        ),
                                        SizedBox(width: 10.w,),
                                        targetWidget(
                                            title: AppStrings.targetCO2,
                                            suffixText: "ppm",
                                            hintText: AppStrings.cO2,
                                            controller: controller.dayCo2Controller
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        lightWidget(
                                            mode: AppStrings.lightONTime,
                                            hourController: controller.dayLightOnHourController,
                                            minuteController: controller.dayLightOnMinuteController
                                        ),
                                        SizedBox(width: 15.w,),
                                        lightWidget(
                                            mode: AppStrings.lightOFFTime,
                                            hourController: controller.dayLightOffHourController,
                                            minuteController: controller.dayLightOffMinuteController
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.w,
                                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImages.fillMoon,
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                        SizedBox(width: 10.w,),
                                        CustomText(
                                          text: AppStrings.nightMode,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightBlue,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        targetWidget(
                                            title: AppStrings.targetC,
                                            suffixText: "°C",
                                            hintText: AppStrings.t,
                                            controller: controller.nightTemperatureController
                                        ),
                                        SizedBox(width: 10.w,),
                                        targetWidget(
                                            title: AppStrings.targetRH,
                                            suffixText: "%",
                                            hintText: AppStrings.rH,
                                            controller: controller.nightRhController
                                        ),
                                        SizedBox(width: 10.w,),
                                        targetWidget(
                                            title: AppStrings.targetCO2,
                                            suffixText: "ppm",
                                            hintText: AppStrings.cO2,
                                            controller: controller.nightCo2Controller
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        lightWidget(
                                            mode: AppStrings.lightONTime,
                                            hourController: controller.nightLightOnHourController,
                                            minuteController: controller.nightLightOnMinuteController
                                        ),
                                        SizedBox(width: 15.w,),
                                        lightWidget(
                                            mode: AppStrings.lightOFFTime,
                                            hourController: controller.nightLightOffHourController,
                                            minuteController: controller.nightLightOffMinuteController
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.w,
                                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.irrigationSchedule,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    SizedBox(height: 5.h,),
                                    CustomDropDown(
                                        hintText: AppStrings.chooseSchedule,
                                      itemList: controller.irrigationList,
                                      value: controller.irrigationValue.value,
                                      onChange: (value) {
                                        controller.irrigationValue.value = value;
                                      },
                                    ),
                                    SizedBox(height: 10.h,),
                                    CustomText(
                                      text: AppStrings.fertigationFormula1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    SizedBox(height: 5.h,),
                                    CustomDropDown(
                                        hintText: AppStrings.chooseFormula,
                                      itemList: controller.fertigationList1,
                                      value: controller.fertigationValue1.value,
                                      onChange: (value) {
                                        controller.fertigationValue1.value = value;
                                      },
                                    ),
                                    SizedBox(height: 10.h,),
                                    CustomText(
                                      text: AppStrings.fertigationFormula2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightText,
                                    ),
                                    SizedBox(height: 5.h,),
                                    CustomDropDown(
                                        hintText: AppStrings.chooseFormula,
                                      itemList: controller.fertigationList2,
                                      value: controller.fertigationValue2.value,
                                      onChange: (value) {
                                        controller.fertigationValue2.value = value;
                                      },
                                    ),
                                    SizedBox(height: 10.h,),
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
                                    SizedBox(height: 10.h,),
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
                                    )
                                  ],
                                ),
                              ),
                            ],
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
              ),
              SizedBox(height: 30.h,)
            ],
          ),
        ),
      ),
    );
  }

  Widget listWidget () {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: AppStrings.oGKushSeedlingSheet,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.buttonColor,
                    ),
                    Expanded(child: SizedBox(width: 10.w,)),
                    PopupMenuButton<int>(
                      offset: Offset(0, 18.h),
                      padding: EdgeInsets.zero,
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      constraints: BoxConstraints(
                          maxWidth: 115.w,
                          maxHeight: 147.h
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
                                        AppImages.lightSelectToggle,
                                        height: 25.h,
                                        width: 25.w,
                                      ),
                                      SizedBox(width: 10.w,),
                                      CustomText(
                                        text: AppStrings.apply,
                                        fontSize: 15.sp,
                                        color: AppColors.buttonColor,
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
                                        color: Get.isDarkMode
                                            ? AppColors.darkText : AppColors.lightGray1,
                                      ),
                                      SizedBox(width: 10.w,),
                                      CustomText(
                                        text: AppStrings.edit,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkText : AppColors.lightGray1,
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
                            padding: EdgeInsets.zero,
                            value: 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        AppImages.export,
                                        height: 25.h,
                                        width: 25.w,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                      ),
                                      SizedBox(width: 10.w,),
                                      CustomText(
                                        text: AppStrings.export,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
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
                              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 9.h),
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
                SizedBox(height: 6.h,),
                Text(
                  AppStrings.tODesc,
                  style: TextStyleDecoration.body1,
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.seedBank,
                    value: AppStrings.bankName
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.temperature,
                    value: "24°C / 26°C"
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.rH,
                    value: "75% / 80%"
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.cO2,
                    value: "950 ppm"
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.irrigation,
                    value: AppStrings.scheduleName
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.fertigation,
                    value: AppStrings.formulaName
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h,)
      ],
    );
  }

  Widget commonWidget({
    required String title,
    required String value}) {
    return Row(
      children: [
        CustomText(
          text: title,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        CustomText(
          text: value,
          color: AppColors.buttonColor,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ],
    );
  }

  Widget targetWidget( {
    required String title,
    required String suffixText,
    required String hintText,
    required TextEditingController controller
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        SizedBox(height: 5.h,),
        SizedBox(
          height: 40.h,
          width: 90.w,
          child: CustomTextField(
            controller: controller,
            textInputType: TextInputType.number,
            contentPadding: EdgeInsets.only(left: 10.w),
            borderRadius: 8,
            hintText: hintText,
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 5.w, top: 8.h, left: 15.w),
              child: CustomText(
                text: suffixText,
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 14.sp,
              ),
            ),
            onchange: (val){},
          ),
        )
      ],
    );
  }

  Widget hourTextField( {
    required TextEditingController controller}) {
    return SizedBox(
      height: 39.h,
      width: 50.w,
      child: CustomTextField(
        controller: controller,
        textInputType: TextInputType.number,
        borderRadius: 8,
        hintText: AppStrings.hh,
        onchange: (val){},
      ),
    );
  }

  Widget minuteTextField( {required TextEditingController controller}) {
    return SizedBox(
      height: 40.h,
      width: 50.w,
      child: CustomTextField(
        controller: controller,
        textInputType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        borderRadius: 8,
        hintText: AppStrings.mm,
        contentPadding: EdgeInsets.only(left: 15.w,top: 10.h, bottom: 10.h, right: 10.w),
        onchange: (val){},
      ),
    );
  }

  Widget lightWidget({
    required String mode,
    required TextEditingController hourController,
    required TextEditingController minuteController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: mode,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 5.h,),
        Row(
          children: [
            hourTextField(
              controller: hourController,
            ),
            SizedBox(width: 5.w,),
            CustomText(
              text: ":",
              color: AppColors.subTitleColor,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
            SizedBox(width: 5.w,),
            minuteTextField(
                controller: minuteController
            )
          ],
        )
      ],
    );
  }
}
