import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget growSheetWidget( {
  required BuildContext context,
  required RxString selectStage,
  required RxBool isGermination,
  required RxBool isSeedling,
  required RxBool isVegetative,
  required RxBool isFlowering,
  required DateRangePickerController plantedDate,
  required DateRangePickerController harvestDate,
  required RxString plantedDateValue,
  required RxString harvestDateValue,
  required TextEditingController controller
} ) {
  return Obx(() => Container(
    width: Get.width,
    color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
    child: Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(15.w),
          child: Row(
            children: [
              CustomText(
                text: AppStrings.growsheet,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              Image.asset(
                AppImages.horizontalMenu,
                height: 20.h,
                width: 20.w,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightText,
              )
            ],
          ),
        ),
        Divider(
          thickness: 1.2.w,
          color: Get.isDarkMode
              ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
        ),
        Padding(
          padding:  EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.theTypeOfPlant,
                fontSize: 20.sp,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 5.h,),
              CustomText(
                text: AppStrings.theGenealogy,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(height: 10.h,),
              Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColors.darkBlue : AppColors.lightAppbar,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.stage,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          PopupMenuButton<int>(
                            offset: Offset(0, 23.h),
                            padding: EdgeInsets.zero,
                            color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                            constraints: BoxConstraints(
                                maxWidth: 135.w,
                                maxHeight: 138.h
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                CustomText(
                                  text: selectStage.value,
                                  fontSize: 15.sp,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(width: 1.w,),
                                Image.asset(
                                  AppImages.downArrow,
                                  color: AppColors.red,
                                  height: 25.h,
                                  width: 25.w,
                                ),
                              ],
                            ),
                            onSelected: (item) {},
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                  padding: EdgeInsets.zero,
                                  value: 0,
                                  onTap: (){
                                    selectStage.value = AppStrings.germination;
                                    isGermination.value = true;
                                    isSeedling.value = false;
                                    isVegetative.value = false;
                                    isFlowering.value = false;
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                        child: CustomText(
                                          text: AppStrings.germination,
                                          fontSize: 15.sp,
                                          color: isGermination.value == true
                                              ? AppColors.buttonColor : Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightGray1,
                                          fontWeight: FontWeight.w500,
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
                                  onTap: (){
                                    selectStage.value = AppStrings.seedling;
                                    isGermination.value = false;
                                    isSeedling.value = true;
                                    isVegetative.value = false;
                                    isFlowering.value = false;
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                        child: CustomText(
                                          text: AppStrings.seedling,
                                          fontSize: 15.sp,
                                          color: isSeedling.value == true
                                              ? AppColors.buttonColor : Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightGray1,
                                          fontWeight: FontWeight.w500,
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
                                  onTap: (){
                                    selectStage.value = AppStrings.vegetative;
                                    isGermination.value = false;
                                    isSeedling.value = false;
                                    isVegetative.value = true;
                                    isFlowering.value = false;
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                        child: CustomText(
                                          text: AppStrings.vegetative,
                                          fontSize: 15.sp,
                                          color: isVegetative.value == true
                                              ? AppColors.buttonColor : Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightGray1,
                                          fontWeight: FontWeight.w500,
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
                                  height: 20.h,
                                  onTap: (){
                                    selectStage.value = AppStrings.flowering;
                                    isGermination.value = false;
                                    isSeedling.value = false;
                                    isVegetative.value = false;
                                    isFlowering.value = true;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                    child: CustomText(
                                      text: AppStrings.flowering,
                                      fontSize: 15.sp,
                                      color: isFlowering.value == true
                                          ? AppColors.buttonColor : Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.planted,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return picDate(
                                        date: plantedDate,
                                      dateValue: plantedDateValue
                                    );
                                  }
                              );
                            },
                            child: CustomText(
                              text: plantedDateValue.isNotEmpty ? plantedDateValue.value : AppStrings.chooseDate,
                              fontSize: 15.sp,
                              color: Get.isDarkMode
                                  ? plantedDateValue.isNotEmpty
                                  ? Colors.white : AppColors.darkText
                                  : plantedDateValue.isNotEmpty
                                  ? Colors.black : AppColors.lightText.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.estimatedHarvestTime,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return picDate(
                                        date: harvestDate,
                                      dateValue: harvestDateValue
                                    );
                                  }
                              );
                            },
                            child: CustomText(
                              text: harvestDateValue.isNotEmpty
                                  ? harvestDateValue.value : AppStrings.chooseDate,
                              fontSize: 15.sp,
                              color: Get.isDarkMode
                                  ? harvestDateValue.isNotEmpty
                                  ? Colors.white : AppColors.darkText
                                  :  harvestDateValue.isNotEmpty
                                  ? Colors.black : AppColors.lightText.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.barcode,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          Expanded(
                            child: SizedBox(
                              height: 30.h,
                              child: TextFormField(
                                controller: controller,
                                cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15.sp,
                                  color: Get.isDarkMode ? Colors.white : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.buttonColor
                                    ),
                                  ),
                                  hintText: AppStrings.barcode,
                                  contentPadding: EdgeInsets.only(right: 10.w),
                                    hintStyle:  TextStyle(
                                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText.withOpacity(0.5),
                                      fontSize:  14.sp,
                                      fontFamily: "Poppins",
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: -15,
                    endAngle: 350,
                    radiusFactor: 0.80,
                    canScaleToFit: true,
                    axisLineStyle:  AxisLineStyle(
                      thickness: 0.25,
                      color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
                      thicknessUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.startCurve,
                    ),
                    pointers: const <GaugePointer>[
                      RangePointer(
                        value: 85,
                        width: 0.25,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: AppColors.pink,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      RangePointer(
                          value: 65,
                          width: 0.25,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: AppColors.lightGreen3,
                          cornerStyle: CornerStyle.bothCurve),
                      RangePointer(
                          value: 45,
                          width: 0.25,
                          color: AppColors.purple,
                          sizeUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.bothCurve),
                    ],
                    annotations: [
                      GaugeAnnotation(
                          widget: Center(
                            child: Padding(
                              padding:  EdgeInsets.only(left: 30.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: "75%",
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Get.isDarkMode
                                        ? Colors.white : Colors.black,
                                  ),
                                  CustomText(
                                    text: AppStrings.progress,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightGray1,
                                    fontSize: 20.sp,
                                  )
                                ],
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  ));
}

Widget picDate({required DateRangePickerController date, required RxString dateValue}) {
  return AlertDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    backgroundColor: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10.h,),
        SizedBox(
          width: 200.w,
          height: 220.h,
          child: SfDateRangePicker(
            showActionButtons: true,
            controller: date,
            view: DateRangePickerView.month,
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14.sp,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontWeight: FontWeight.w500
              ),
            ),
            onSubmit: (context){
              Get.back();
              AppConst().debug('Select date => ${date.selectedDate}');
              dateValue.value = "${date.selectedDate!.day}.${date.selectedDate!.month}.${date.selectedDate!.year}";
            },
            onCancel: (){
              Get.back();
            },
            showNavigationArrow: true,
            monthViewSettings: DateRangePickerMonthViewSettings(
              showTrailingAndLeadingDates: true,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12.sp,
                      color: Get.isDarkMode ? AppColors.darkBlue3 : AppColors.lightIcon,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontWeight: FontWeight.w500
              ),
              disabledDatesTextStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  fontWeight: FontWeight.w500
              ),
              todayTextStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                  color: Get.isDarkMode ? Colors.white : AppColors.lightText,
                  fontWeight: FontWeight.w500
              ),
            ),
            selectionColor: AppColors.buttonColor,
            todayHighlightColor: AppColors.lightIcon,
            selectionTextStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    ),
  );
}