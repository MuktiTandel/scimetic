import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/reports/controller/reports_controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);

  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: context.theme.cardColor,
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.generateReport,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.lightBorder,
                      ),
                      Obx(() => controller.isValid.value == false
                          ? SizedBox(
                              height: 10.h,
                            )
                          : const SizedBox.shrink()),
                      Obx(
                        () => controller.isValid.value == true
                            ? const SizedBox.shrink()
                            : commonErrorWidget(
                                onTap: () {
                                  controller.isValid.value = true;
                                },
                                errorMessage: controller.errorMessage.value),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      commonTextField(
                          title: AppStrings.name,
                          controller: controller.nameController,
                          hintText: AppStrings.name),
                      SizedBox(
                        height: 15.h,
                      ),
                      commonTextField(
                          title: AppStrings.companyName,
                          controller: controller.companyNameController,
                          hintText: AppStrings.companyName),
                      SizedBox(
                        height: 15.h,
                      ),
                      commonTextField(
                          title: AppStrings.batchID,
                          controller: controller.batchIdController,
                          hintText: AppStrings.batchID),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomText(
                        text: AppStrings.sensor,
                        color:
                            Get.isDarkMode ? Colors.white : AppColors.lightText,
                        fontSize: 12.h,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomDropDown(
                        width: 330.w,
                        hintText: AppStrings.chooseSensor,
                        itemList: controller.sensorList,
                        value: controller.chooseSensor.value,
                        onChange: (value) {
                          controller.chooseSensor.value = value;
                          if (value.contains(AppStrings.temperature)) {
                            controller.chooseSensor.value = "temperature";
                          } else if (value.contains(AppStrings.cO2)) {
                            controller.chooseSensor.value = "co2";
                          } else if (value.contains(AppStrings.humidity)) {
                            controller.chooseSensor.value = "humidity";
                          } else if (value.contains(AppStrings.vpd)) {
                            controller.chooseSensor.value = "vpd";
                          }
                        },
                        isEdit: false.obs,
                        isEnable: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomText(
                        text: AppStrings.dateRange,
                        color:
                            Get.isDarkMode ? Colors.white : AppColors.lightText,
                        fontSize: 12.h,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          dateTextField(
                              enable: false,
                              controller: controller.startDate,
                              hintText: AppStrings.startDate,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return selectDateDialog(
                                          dateController:
                                              controller.startDateController,
                                          textController: controller.startDate);
                                    });
                              }),
                          SizedBox(
                            width: 10.w,
                          ),
                          dateTextField(
                              enable: false,
                              controller: controller.endDate,
                              hintText: AppStrings.endDate,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return selectDateDialog(
                                          dateController:
                                              controller.endDateController,
                                          textController: controller.endDate);
                                    });
                              })
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                        onTap: () {},
                        buttonText: AppStrings.upload,
                        backgroundColor: AppColors.subTitleColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      OutLineButton(
                        onTap: () async {
                          await controller.onGenerate();
                          await controller.screenshotController
                              .capture(delay: const Duration(milliseconds: 500))
                              .then((value) async {
                            controller.image = value;
                            AppConst().debug("image => $value");
                          }).catchError((onError) {
                            AppConst().debug("$onError");
                          });
                          controller.makePdf(
                              companyName:
                                  controller.companyNameController.text,
                              batchId: controller.batchIdController.text,
                              createdBy: controller.nameController.text);
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return PdfPreviewPage();
                          // }));
                        },
                        width: Get.width,
                        height: 45.h,
                        buttonText: AppStrings.generateExport,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                        onTap: () {
                          controller.onGenerate();
                        },
                        buttonText: AppStrings.generate,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => controller.isGetData.value == true
                    ? Screenshot(
                        controller: controller.screenshotController,
                        child: Container(
                          height: 362.h,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Obx(() => CustomText(
                                      text: controller.chooseSensor.value,
                                      fontSize: 15.sp,
                                      color: AppColors.subTitleColor,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              SizedBox(
                                height: 274.h,
                                child: SfCartesianChart(
                                  margin: const EdgeInsets.all(0),
                                  plotAreaBorderColor: Colors.transparent,
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x,
                                      enablePanning: true),
                                  primaryYAxis: NumericAxis(
                                    majorTickLines:
                                        const MajorTickLines(width: 0),
                                    labelFormat:
                                        '{value} ${controller.format.value}',
                                    majorGridLines: MajorGridLines(
                                        width: 1.w,
                                        dashArray: const [7, 7],
                                        color: Get.isDarkMode
                                            ? Colors.white38
                                            : AppColors.subTitleColor
                                                .withOpacity(0.3)),
                                    axisLine: const AxisLine(
                                        color: Colors.transparent, width: 0),
                                    labelPosition:
                                        ChartDataLabelPosition.inside,
                                    labelAlignment: LabelAlignment.end,
                                    plotOffset: 20,
                                    minimum: 0,
                                    maximum: double.parse(controller
                                        .maxValue.value
                                        .toStringAsFixed(0)),
                                    labelStyle: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.subTitleColor,
                                      fontSize: 10.h,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  primaryXAxis: DateTimeAxis(
                                    dateFormat: DateFormat("HH:mm"),
                                    maximumLabels: 23,
                                    intervalType: DateTimeIntervalType.hours,
                                    // interval: controller
                                    //     .endDateController.selectedDate!
                                    //     .difference(controller
                                    //         .startDateController.selectedDate!)
                                    //     .inDays
                                    //     .toDouble(),

                                    // maximum: controller
                                    //     .endDateController.selectedDate!,
                                    // minimum: controller
                                    //     .startDateController.selectedDate!,
                                    majorGridLines: const MajorGridLines(
                                      width: 0,
                                    ),
                                    majorTickLines:
                                        const MajorTickLines(width: 0),
                                    axisLine: const AxisLine(width: 0),
                                    labelStyle: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : AppColors.subTitleColor,
                                        fontSize: 10.h,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                  ),
                                  series: [
                                    AreaSeries<ChartSampleData, DateTime>(
                                      dataSource: controller.chartDataList,
                                      opacity: 0.7,
                                      borderColor: AppColors.red,
                                      borderWidth: 1,
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.red.withOpacity(0.5),
                                            AppColors.red.withOpacity(0.5),
                                          ]),
                                      xValueMapper:
                                          (ChartSampleData point, _) => point.x,
                                      yValueMapper:
                                          (ChartSampleData point, _) =>
                                              point.low,
                                    ),
                                    // HiloSeries<ChartSampleData, DateTime>(
                                    //   dataSource: controller.chartDataList,
                                    //   name: 'AAPL',
                                    //   // showIndicationForSameValues: isCardView ? true : _toggleVisibility,
                                    //   xValueMapper:
                                    //       (ChartSampleData sales, _) =>
                                    //           sales.x as DateTime,
                                    //   color: AppColors.red,

                                    //   /// High, low, open and close values used to render the HLOC series.
                                    //   lowValueMapper:
                                    //       (ChartSampleData sales, _) =>
                                    //           sales.low,
                                    //   highValueMapper:
                                    //       (ChartSampleData sales, _) =>
                                    //           sales.high,
                                    //   // openValueMapper: (ChartSampleData sales, _) => sales.open,
                                    //   // closeValueMapper: (ChartSampleData sales, _) => sales.close
                                    // )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: DateFormat.MMMMd().format(controller
                                          .startDateController.selectedDate!),
                                      fontSize: 15.sp,
                                      color: AppColors.subTitleColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: DateFormat.MMMMd().format(controller
                                          .endDateController.selectedDate!),
                                      fontSize: 15.sp,
                                      color: AppColors.subTitleColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commonTextField(
      {required String title,
      required TextEditingController controller,
      required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: Get.isDarkMode ? Colors.white : AppColors.lightText,
          fontSize: 12.h,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          height: 40.h,
          child: CustomTextField(
            controller: controller,
            borderRadius: 8,
            hintText: hintText,
            hintTextSize: 12.sp,
            focusBorderColor: AppColors.buttonColor,
            isFilled: Get.isDarkMode ? true : false,
            onchange: (value) {},
          ),
        ),
      ],
    );
  }

  Widget dateTextField(
      {required TextEditingController controller,
      required String hintText,
      bool? enable,
      required VoidCallback onTap}) {
    return Expanded(
      child: SizedBox(
        height: 40.h,
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: CustomTextField(
            enable: enable,
            readOnly: true,
            controller: controller,
            hintText: hintText,
            contentPadding: EdgeInsets.only(left: 10.w),
            suffixWidget: GestureDetector(
              onTap: () {
                onTap();
              },
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Image.asset(
                  AppImages.calender,
                  color:
                      Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  height: 10.h,
                  width: 10.w,
                ),
              ),
            ),
            onchange: (value) {},
          ),
        ),
      ),
    );
  }

  Widget selectDateDialog(
      {required DateRangePickerController dateController,
      required TextEditingController textController}) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      backgroundColor: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
      content: SizedBox(
        width: 200.w,
        height: 220.h,
        child: SfDateRangePicker(
          showActionButtons: true,
          controller: dateController,
          view: DateRangePickerView.month,
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                fontWeight: FontWeight.w500),
          ),
          onSubmit: (context) {
            Get.back();
            AppConst().debug('Select date => ${dateController.selectedDate}');
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            textController.text =
                formatter.format(dateController.selectedDate!);
          },
          onCancel: () {
            Get.back();
          },
          showNavigationArrow: true,
          monthViewSettings: DateRangePickerMonthViewSettings(
            showTrailingAndLeadingDates: true,
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12.sp,
                    color: Get.isDarkMode
                        ? AppColors.darkBlue3
                        : AppColors.lightIcon,
                    fontWeight: FontWeight.w500)),
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                fontWeight: FontWeight.w500),
            disabledDatesTextStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12.sp,
                color:
                    Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontWeight: FontWeight.w500),
            todayTextStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.lightText,
                fontWeight: FontWeight.w500),
          ),
          selectionColor: AppColors.buttonColor,
          todayHighlightColor: AppColors.lightIcon,
          selectionTextStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
