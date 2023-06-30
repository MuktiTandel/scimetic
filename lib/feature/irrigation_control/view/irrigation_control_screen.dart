import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_description_textfield.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_popup.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/irrigation_control/controller/irrigation_controller.dart';
import 'package:scimetic/feature/irrigation_control/model/irrigation_control_model.dart';

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
                    isFilled: true,
                    borderRadius: 8,
                    hintText: AppStrings.search,
                    focusBorderColor: AppColors.buttonColor,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(13.w),
                      child: Image.asset(
                        AppImages.search,
                        color: Get.isDarkMode
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                    onchange: (value) {
                      if (value.isNotEmpty) {
                        controller.irrigationList.value = controller
                            .irrigationList
                            .where((element) => element.name!.contains(value))
                            .toList();
                      } else {
                        controller.irrigationList.clear();
                        controller.irrigationList.addAll(controller.mainList);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.isCheckAll.value =
                              !controller.isCheckAll.value;
                          if (controller.isCheckAll.value == true) {
                            controller.isSelect.value = true;
                            for (var element in controller.selectList) {
                              element.value = true;
                            }
                            for (var element in controller.irrigationList) {
                              controller.irrigationControlIds.add(element.id);
                            }
                          } else {
                            controller.irrigationControlIds.clear();
                            controller.isSelect.value = false;
                            for (var element in controller.selectList) {
                              element.value = false;
                            }
                          }
                        },
                        child: controller.isCheckAll.value == false
                            ? Image.asset(
                                AppImages.unSelectedBox,
                                height: 20.h,
                                width: 20.w,
                                color: Get.isDarkMode
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              )
                            : Image.asset(
                                AppImages.selectedBox,
                                height: 20.h,
                                width: 20.w,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: AppStrings.checkAll,
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode
                          ? AppColors.darkText
                          : AppColors.lightText,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Obx(() => controller.isCheckAll.value == true ||
                            controller.isSelect.value == true
                        ? GestureDetector(
                            onTap: () async {
                              controller.isSelect.value = false;
                              controller.irrigationControlIds.clear();
                              for (int i = 0;
                              i < controller.selectList.length;
                              i++) {
                                bool isSelect = controller.selectList[i].value;
                                if (isSelect == true) {
                                  IrrigationControl data =
                                  controller.irrigationList[i];
                                  controller.irrigationControlIds
                                      .add(data.id!);
                                }
                              }
                              AppConst().debug(
                                  'id list => ${controller.irrigationControlIds}');
                              await controller
                                  .deleteIrrigationControl()
                                  .whenComplete(() async {
                                await controller.getIrrigationControlData();
                              });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.trash,
                                  height: 20.h,
                                  width: 25.w,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                CustomText(
                                  text: AppStrings.delete,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.red,
                                  fontSize: 13.sp,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink())
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: AppBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() => controller.isGetData.value == true
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.irrigationList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return listWidget(
                                  data: controller.irrigationList[index],
                                  isShow: controller.showList[index],
                                  isSelect: controller.selectList[index],
                                  isApplied: controller.appliedList[index]
                              );
                            })
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: CustomButton(
                        height: 30.h,
                        width: 85.w,
                        onTap: () {
                          Get.dialog(
                            dialogWidget()
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
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text(AppStrings.add)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
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

  Widget listWidget(
      {required IrrigationControl data,
      required RxBool isShow,
      required RxBool isSelect,
      required RxBool isApplied}) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            isSelect.value = !isSelect.value;
                            controller.checkList.clear();
                            for (var element in controller.selectList) {
                              if ( element.value == true ) {
                                controller.checkList.add(element.value);
                              }
                            }
                            if ( controller.checkList.isNotEmpty ) {
                              controller.isSelect.value = true;
                            } else {
                              controller.isSelect.value = false;
                            }
                          },
                          child: isSelect.value == false
                              ? Image.asset(
                                  AppImages.unSelectedBox,
                                  height: 18.h,
                                  width: 18.w,
                                  color: Get.isDarkMode
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                )
                              : Image.asset(
                                  AppImages.selectedBox,
                                  height: 18.h,
                                  width: 18.w,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text: data.name ?? "",
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      commonPopup(
                          deleteTap: () async {
                            controller.irrigationControlIds.clear();
                            controller.irrigationControlIds.add(data.id!);
                            await controller.deleteIrrigationControl().whenComplete(() async {
                              await controller.getIrrigationControlData();
                            });
                          },
                          applyTap: () async{
                            controller.isApply.value =
                            !controller.isApply.value;

                            bool isApply = await controller.toggleApply(
                                applied: controller.isApply.value,
                                id: data.id ?? 0);

                            if (isApply == true) {
                              if (isApplied.value == true) {
                                isApplied.value = false;
                              } else {
                                isApplied.value = true;
                              }
                            }
                          },
                          isApply: controller.isApply,
                          editTap: () {
                            controller.isEdit.value = true;

                            controller.irrigationId.value = data.id ?? 0;

                            controller.day100TemperatureController.text = "${data.day100Temperature}";
                            controller.day100DurationController.text = "${data.day100Duration}";
                            controller.day0TemperatureController.text = "${data.day0Temperature}";
                            controller.day0DurationController.text = "${data.day0Duration}";

                            if ( data.schedules!.isNotEmpty ) {
                              controller.dayHourList.clear();
                              controller.dayMinuteList.clear();
                              controller.nightHourList.clear();
                              controller.nightMinuteList.clear();

                              for ( int i = 0; i < data.schedules!.length; i++ ) {
                                controller.dayHourList.add(TextEditingController());
                                controller.dayMinuteList.add(TextEditingController());
                                controller.nightHourList.add(TextEditingController());
                                controller.nightMinuteList.add(TextEditingController());
                              }

                              if ( controller.dayHourList.length == data.schedules!.length ) {

                                for ( int i = 0; i < data.schedules!.length; i++ ) {

                                  controller.listHeight.value =
                                      controller.listHeight.value +
                                          70.0;

                                  Schedule schedule = data.schedules![i];

                                  if ( schedule.dayTimeActivate!.isNotEmpty ) {
                                    final dayStart = schedule.dayTimeActivate!;

                                    AppConst().debug(dayStart);

                                    final split = dayStart.split(":");

                                    final Map<int, String> values = {
                                      for (int i = 0; i < split.length; i++)
                                        i: split[i]
                                    };

                                    AppConst().debug('${values[0]}');

                                    controller.dayHourList[i].text = values[0]!;
                                    controller.dayMinuteList[i].text = values[1]!;
                                  }

                                  if ( schedule.nightTimeActivate!.isNotEmpty ) {
                                    final dayStart = schedule.nightTimeActivate!;

                                    AppConst().debug(dayStart);

                                    final split = dayStart.split(":");

                                    final Map<int, String> values = {
                                      for (int i = 0; i < split.length; i++)
                                        i: split[i]
                                    };

                                    AppConst().debug('${values[0]}');

                                    controller.nightHourList[i].text = values[0]!;
                                    controller.nightMinuteList[i].text = values[1]!;
                                  }

                                }
                              }

                            }

                            controller.night100TemperatureController.text = "${data.night100Temperature}";
                            controller.night100DurationController.text = "${data.night100Duration}";
                            controller.night0TemperatureController.text = "${data.night0Temperature}";
                            controller.night0DurationController.text = "${data.night0Duration}";

                            controller.nameController.text = data.name ?? "";
                            controller.tagController.text = data.tag ?? "";
                            controller.descriptionController.text = data.description ?? "";

                            Future.delayed(const Duration(milliseconds: 500), (){
                              Get.dialog(
                                  dialogWidget()
                              );
                            });

                          }),
                      SizedBox(
                        width: 10.w,
                      ),
                      Obx(() => GestureDetector(
                            onTap: () {
                              isShow.value = !isShow.value;
                            },
                            child: Image.asset(
                              isShow.value == false
                                  ? AppImages.downArrow
                                  : AppImages.upArrow,
                              height: 22.h,
                              width: 22.w,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.tag,
                        height: 15.h,
                        width: 15.w,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.subTitleColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text: data.tag ?? "",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.subTitleColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    data.description ?? "",
                    style: TextStyleDecoration.body1,
                  ),
                  Obx(() => isShow.value == true
                      ? SizedBox(
                          height: 10.h,
                        )
                      : const SizedBox.shrink()),
                  Obx(() => isShow.value == true
                      ? Row(
                          children: [
                            Expanded(
                              child: commonTimeWidget(
                                  title: AppStrings.day,
                                  scheduleData: data.schedules ?? [],
                                  isDay: true),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: commonTimeWidget(
                                  title: AppStrings.night,
                                  scheduleData: data.schedules ?? [],
                                  isDay: false),
                            ),
                          ],
                        )
                      : const SizedBox.shrink())
                ],
              ),
            ),
            Obx(() => isApplied.value == true
                ? Positioned(
                    right: 50.w,
                    child: Image.asset(
                      AppImages.applied,
                      height: 22.h,
                      width: 100.w,
                    ),
                  )
                : const SizedBox.shrink())
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  Widget commonTimeWidget(
      {required String title,
      required List<Schedule> scheduleData,
      required bool isDay}) {
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
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: scheduleData.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return timeWidget(
                    count: index + 1,
                    dayTimeActivate: scheduleData[index].dayTimeActivate ?? "",
                    nightTimeActivate:
                        scheduleData[index].nightTimeActivate ?? "",
                    isDay: isDay);
              })
        ],
      ),
    );
  }

  Widget timeWidget(
      {required int count,
      required String dayTimeActivate,
      required String nightTimeActivate,
      required bool isDay}) {
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
            SizedBox(
              width: 10.w,
            ),
            CustomText(
              text: isDay == true ? dayTimeActivate : nightTimeActivate,
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 13.sp,
            )
          ],
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }

  Widget customTextField(
      {required String title,
      required TextEditingController controller,
      required String hintText,
      TextInputType? textInputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
          fontSize: 12.h,
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          height: 40.h,
          child: CustomTextField(
            controller: controller,
            borderRadius: 8,
            textInputType: textInputType ?? TextInputType.number,
            contentPadding: EdgeInsets.only(left: 10.w),
            hintText: hintText,
            hintTextSize: 12.sp,
            focusBorderColor: AppColors.buttonColor,
            isFilled: true,
            onchange: (value) {},
          ),
        ),
      ],
    );
  }

  Widget commonHourTimeWidget(
      {required int count,
      required TextEditingController hourController,
      required TextEditingController minuteController}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CustomText(
              text: "#$count",
              fontWeight: FontWeight.w500,
              fontSize: 22.sp,
              color: AppColors.buttonColor,
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.timeActivate,
                  color:
                      Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  fontSize: 12.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    commonTimeTextField(
                        controller: hourController,
                        hintText: AppStrings.hh,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (int.parse(value) > 23) {
                              hourController.text = "23";
                            }
                          }
                        },
                        isField: true),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomText(
                      text: ":",
                      color: Get.isDarkMode
                          ? AppColors.darkText
                          : AppColors.lightText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    commonTimeTextField(
                        controller: minuteController,
                        hintText: AppStrings.mm,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (int.parse(value) > 59) {
                              minuteController.text = "59";
                            }
                          }
                        },
                        isField: true)
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  Widget dialogWidget() {
    return CommonDialogWidget(
        title: AppStrings.addNewSchedules,
        onTap: () {
          controller.listHeight.value = 80.0;
          controller.dayMinuteList.clear();
          controller.dayMinuteList
              .add(TextEditingController());
          controller.dayHourList.clear();
          controller.dayHourList
              .add(TextEditingController());
          controller.nightMinuteList.clear();
          controller.nightMinuteList
              .add(TextEditingController());
          controller.nightHourList.clear();
          controller.nightHourList
              .add(TextEditingController());
          controller.day100TemperatureController.clear();
          controller.day100DurationController.clear();
          controller.day0TemperatureController.clear();
          controller.day0DurationController.clear();
          for (var element in controller.dayHourList) {
            element.clear();
          }
          for (var element in controller.dayMinuteList) {
            element.clear();
          }
          controller.night100TemperatureController
              .clear();
          controller.night100DurationController.clear();
          controller.night0TemperatureController.clear();
          controller.night0DurationController.clear();
          for (var element in controller.nightHourList) {
            element.clear();
          }
          for (var element
          in controller.nightMinuteList) {
            element.clear();
          }
          Get.back();
        },
        widget: SizedBox(
          width: 350.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.w),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() =>
                    controller.isValid.value == true
                        ? const SizedBox.shrink()
                        : Column(
                      children: [
                        commonErrorWidget(
                            onTap: () {
                              controller.isValid
                                  .value = true;
                            },
                            errorMessage:
                            controller
                                .errorMessage
                                .value),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    )),
                    Row(
                      children: [
                        Image.asset(
                          AppImages.fillSun,
                          height: 20.h,
                          width: 20.w,
                          color: AppColors.lightBlue,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: AppStrings
                              .dayIrrigationMode,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    commonTexField(
                        title: AppStrings.temperature100,
                        controller: controller
                            .day100TemperatureController,
                        suffixText: "°C",
                        hintText: AppStrings.temperature,
                        onChanged: (value) {}),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                        title: AppStrings.duration,
                        controller: controller
                            .day100DurationController,
                        hintText: AppStrings.duration),
                    SizedBox(
                      height: 10.h,
                    ),
                    commonTexField(
                        title: AppStrings.temperature0,
                        controller: controller
                            .day0TemperatureController,
                        suffixText: "°C",
                        hintText: AppStrings.temperature,
                        onChanged: (value) {}),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                        title: AppStrings.duration,
                        controller: controller
                            .day0DurationController,
                        hintText: AppStrings.duration),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() => SizedBox(
                      height:
                      controller.listHeight.value,
                      child: ListView.builder(
                          itemCount: controller
                              .dayHourList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (BuildContext context,
                              int index) {
                            return commonHourTimeWidget(
                                count: index + 1,
                                hourController:
                                controller
                                    .dayHourList[
                                index],
                                minuteController:
                                controller
                                    .dayMinuteList[
                                index]);
                          }),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: AppColors.lightAppbar,
                padding: EdgeInsets.symmetric(
                    horizontal: 15.w, vertical: 10.h),
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
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: AppStrings
                              .nightIrrigationMode,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    commonTexField(
                        title: AppStrings.temperature100,
                        controller: controller
                            .night100TemperatureController,
                        suffixText: "°C",
                        hintText: AppStrings.temperature,
                        onChanged: (value) {},
                        isFilled: true),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                        title: AppStrings.duration,
                        controller: controller
                            .night100DurationController,
                        hintText: AppStrings.duration),
                    SizedBox(
                      height: 10.h,
                    ),
                    commonTexField(
                        title: AppStrings.temperature0,
                        controller: controller
                            .night0TemperatureController,
                        suffixText: "°C",
                        hintText: AppStrings.temperature,
                        onChanged: (value) {},
                        isFilled: true),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                      title: AppStrings.duration,
                      controller: controller
                          .night0DurationController,
                      hintText: AppStrings.duration,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(() => SizedBox(
                      height:
                      controller.listHeight.value,
                      child: ListView.builder(
                          itemCount: controller
                              .nightHourList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (BuildContext context,
                              int index) {
                            return commonHourTimeWidget(
                                count: index + 1,
                                hourController: controller
                                    .nightHourList[
                                index],
                                minuteController:
                                controller
                                    .nightMinuteList[
                                index]);
                          }),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CustomButton(
                      height: 30.h,
                      width: 130.w,
                      onTap: () {
                        controller.listHeight.value =
                            controller.listHeight.value +
                                95.0;
                        controller.dayHourList
                            .add(TextEditingController());
                        controller.dayMinuteList
                            .add(TextEditingController());
                        controller.nightHourList
                            .add(TextEditingController());
                        controller.nightMinuteList
                            .add(TextEditingController());
                      },
                      buttonText: AppStrings.addSchedule),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      customTextField(
                          title: AppStrings.name,
                          controller:
                          controller.nameController,
                          hintText: AppStrings.name,
                          textInputType:
                          TextInputType.text),
                      SizedBox(
                        height: 10.h,
                      ),
                      customTextField(
                          title: AppStrings.tag,
                          controller:
                          controller.tagController,
                          hintText: AppStrings.tag,
                          textInputType:
                          TextInputType.text),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: AppStrings.description,
                        color: Get.isDarkMode
                            ? AppColors.darkText
                            : AppColors.lightText,
                        fontSize: 12.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      commonDescriptionTextField(
                          controller: controller
                              .descriptionController,
                          descriptionLength: controller
                              .descriptionLength),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutLineButton(
                              onTap: () {
                                controller.listHeight.value = 80.0;
                                controller.dayMinuteList.clear();
                                controller.dayMinuteList
                                    .add(TextEditingController());
                                controller.dayHourList.clear();
                                controller.dayHourList
                                    .add(TextEditingController());
                                controller.nightMinuteList.clear();
                                controller.nightMinuteList
                                    .add(TextEditingController());
                                controller.nightHourList.clear();
                                controller.nightHourList
                                    .add(TextEditingController());
                                controller.day100TemperatureController.clear();
                                controller.day100DurationController.clear();
                                controller.day0TemperatureController.clear();
                                controller.day0DurationController.clear();
                                for (var element in controller.dayHourList) {
                                  element.clear();
                                }
                                for (var element in controller.dayMinuteList) {
                                  element.clear();
                                }
                                controller.night100TemperatureController
                                    .clear();
                                controller.night100DurationController.clear();
                                controller.night0TemperatureController.clear();
                                controller.night0DurationController.clear();
                                for (var element in controller.nightHourList) {
                                  element.clear();
                                }
                                for (var element
                                in controller.nightMinuteList) {
                                  element.clear();
                                }
                                Get.back();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                FocusScope.of(Get.context!)
                                    .unfocus();
                                controller.onSave();
                              },
                              buttonText: AppStrings.save,
                              width: 100.w,
                              height: 40.h,
                              fontSize: 15.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
