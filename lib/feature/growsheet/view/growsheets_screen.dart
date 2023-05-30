import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/growsheet/controller/growsheets_controller.dart';
import 'package:scimetic/feature/growsheet/model/growsheet_model.dart';
import 'package:scimetic/feature/growsheet/model/option_model.dart';

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
                  ],
                ),
              ),
              Obx(() => controller.isGetData.value == false ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonColor,
                ),
              ) : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.growSheetDataList.length,
                  itemBuilder: (BuildContext context, int index) {

                    Growsheet data = controller.growSheetDataList[index];

                    return listWidget(
                      name: data.name ?? "",
                      desc:  data.description ?? "",
                      seedBank: data.seedBank ?? "",
                      dayTemperatureValue: data.dayTargetTemperature.toString(),
                      nightTemperatureValue: data.nightTargetTemperature.toString(),
                      dayHumidityValue: data.dayTargetRelativeHumidity.toString(),
                      nightHumidityValue: data.nightTargetRelativeHumidity.toString(),
                      dayCo2Value: data.dayTargetCo2.toString(),
                      nightCo2Value: data.nightTargetCo2.toString(),
                      irrigationName: data.irrigationControl!.name ?? "",
                      fertigationName1: data.fertigationControl01!.name ?? "",
                      fertigationName2: data.fertigationControl02!.name ?? "",
                      id: data.id!
                    );
                  }
              ),),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(right: 18.w),
                child: CustomButton(
                  height: 30.h,
                  width: 85.w,
                  onTap: () async {
                    await controller.getFormOption().whenComplete(() {
                      Get.dialog(
                          CommonDialogWidget(
                              title: AppStrings.addNewGrowsheet,
                              onTap: (){
                                controller.isValid.value = true;
                                Get.back();
                              },
                              padding: EdgeInsets.zero,
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 15.w, right: 15.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Obx(() => controller.isValid.value == true
                                            ? const SizedBox.shrink()
                                            : commonErrorWidget(
                                            onTap: (){
                                              controller.isValid.value = true;
                                            },
                                            errorMessage: controller.errorMessage.value
                                        )
                                        ),
                                        Obx(() => controller.isValid.value == false
                                            ? SizedBox(height: 10.h,)
                                            : const SizedBox.shrink()
                                        ),
                                        commonTextField(
                                            title: AppStrings.strainName,
                                            controller: controller.strainNameController,
                                            hintText: AppStrings.strainName
                                        ),
                                        SizedBox(height: 10.h,),
                                        commonTextField(
                                            title: AppStrings.seedBank,
                                            controller: controller.seedBankController,
                                            hintText: AppStrings.seedBank
                                        ),
                                        SizedBox(height: 10.h,),
                                        commonTextField(
                                            title: AppStrings.tag,
                                            controller: controller.tagController,
                                            hintText: AppStrings.tag
                                        )
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
                                            targetWidget(
                                              title: AppStrings.deadbandC,
                                              suffixText: "°C",
                                              hintText: AppStrings.t,
                                              controller: controller.dayDeadbandTemperatureController,
                                            ),
                                            SizedBox(width: 10.w,),
                                            targetWidget(
                                                title: AppStrings.deadbandRH,
                                                suffixText: "%",
                                                hintText: AppStrings.rH,
                                                controller: controller.dayDeadbandHumidityController
                                            ),
                                            SizedBox(width: 10.w,),
                                            targetWidget(
                                                title: AppStrings.deadbandCO2,
                                                suffixText: "ppm",
                                                hintText: AppStrings.cO2,
                                                controller: controller.dayDeadbandCo2Controller
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
                                            targetWidget(
                                              title: AppStrings.deadbandC,
                                              suffixText: "°C",
                                              hintText: AppStrings.t,
                                              controller: controller.nightDeadbandTemperatureController,
                                            ),
                                            SizedBox(width: 10.w,),
                                            targetWidget(
                                                title: AppStrings.deadbandRH,
                                                suffixText: "%",
                                                hintText: AppStrings.rH,
                                                controller: controller.nightDeadbandHumidityController
                                            ),
                                            SizedBox(width: 10.w,),
                                            targetWidget(
                                                title: AppStrings.deadbandCO2,
                                                suffixText: "ppm",
                                                hintText: AppStrings.cO2,
                                                controller: controller.nightDeadbandCo2Controller
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
                                        dropDown(
                                          hintText: AppStrings.chooseSchedule,
                                          itemList: controller.irrigationList,
                                          selectValue: controller.irrigationValue,
                                          id: controller.irrigationId
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
                                        dropDown(
                                          hintText: AppStrings.chooseFormula,
                                          itemList: controller.fertigationList1,
                                          selectValue: controller.fertigationValue1,
                                          id: controller.fertigationId1
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
                                        dropDown(
                                          hintText: AppStrings.chooseFormula,
                                          itemList: controller.fertigationList2,
                                          selectValue: controller.fertigationValue2,
                                          id: controller.fertigationId2
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
                                        commonDescriptionTextField(
                                            controller: controller.descriptionController,
                                            descriptionLength: controller.descriptionLength
                                        ),
                                        SizedBox(height: 15.h,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutLineButton(
                                                onTap: (){
                                                  controller.strainNameController.clear();
                                                  controller.tagController.clear();
                                                  controller.descriptionController.clear();
                                                  controller.seedBankController.clear();
                                                  controller.dayDeadbandCo2Controller.clear();
                                                  controller.dayDeadbandHumidityController.clear();
                                                  controller.dayDeadbandTemperatureController.clear();
                                                  controller.dayCo2Controller.clear();
                                                  controller.dayLightOffHourController.clear();
                                                  controller.dayLightOffMinuteController.clear();
                                                  controller.dayLightOnHourController.clear();
                                                  controller.dayLightOnMinuteController.clear();
                                                  controller.dayRhController.clear();
                                                  controller.dayTemperatureController.clear();
                                                  controller.nightDeadbandCo2Controller.clear();
                                                  controller.nightDeadbandHumidityController.clear();
                                                  controller.nightDeadbandTemperatureController.clear();
                                                  controller.nightCo2Controller.clear();
                                                  controller.nightLightOffHourController.clear();
                                                  controller.nightLightOffMinuteController.clear();
                                                  controller.nightLightOnHourController.clear();
                                                  controller.nightLightOnMinuteController.clear();
                                                  controller.nightRhController.clear();
                                                  controller.nightTemperatureController.clear();
                                                  controller.isValid.value = true;
                                                  Get.back();
                                                },
                                                color: AppColors.red,
                                                buttonText: AppStrings.cancel,
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(
                                              child: CustomButton(
                                                onTap: (){
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
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          )
                      );
                    });
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

  Widget listWidget ( {
    required String name,
    required String desc,
    required String seedBank,
    required String dayTemperatureValue,
    required String nightTemperatureValue,
    required String dayHumidityValue,
    required String nightHumidityValue,
    required String dayCo2Value,
    required String nightCo2Value,
    required String irrigationName,
    required String fertigationName1,
    required String fertigationName2,
    required int id
} ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: name,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.buttonColor,
                    ),
                    Expanded(child: SizedBox(width: 10.w,)),
                    commonPopup(
                      deleteTap: () async {
                        controller.growsheetIds.clear();
                        controller.growControllerId.value = controller.storeData.getInt(StoreData.id)!;
                        controller.growsheetIds.add(id);
                        if ( controller.growsheetIds.isNotEmpty ) {
                          await controller.deleteGrowSheet().whenComplete(() async {
                            await controller.getGrowSheetData(id: controller.growControllerId.value);
                          });
                        }
                      }
                    )
                  ],
                ),
                SizedBox(height: 6.h,),
                Text(
                  desc,
                  style: TextStyleDecoration.body1,
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.seedBank,
                    value: seedBank
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.temperature,
                    value: "$dayTemperatureValue°C / $nightTemperatureValue°C"
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.rH,
                    value: "$dayHumidityValue% / $nightHumidityValue%"
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.cO2,
                    value: "$dayCo2Value ppm / $nightCo2Value ppm"
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.irrigation,
                    value: irrigationName
                ),
                SizedBox(height: 10.h,),
                commonWidget(
                    title: AppStrings.fertigation,
                    value: "$fertigationName1 $fertigationName2"
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
          fontSize: 12.sp,
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
            focusBorderColor: AppColors.buttonColor,
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
            commonTimeTextField(
                controller: hourController,
                hintText: AppStrings.hh,
                onChanged: (value) {}
            ),
            SizedBox(width: 5.w,),
            CustomText(
              text: ":",
              color: AppColors.subTitleColor,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
            SizedBox(width: 5.w,),
            commonTimeTextField(
                controller: minuteController,
                hintText: AppStrings.mm,
                onChanged: (value) {}
            ),
          ],
        )
      ],
    );
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
            isFilled: Get.isDarkMode ? true : false,
            onchange: (value){},
          ),
        ),
      ],
    );
  }

  Widget dropDown({
    required IgationControl selectValue,
    required String hintText,
    required List<IgationControl> itemList,
    required RxInt id
  }) {
    return DropdownButtonFormField2<IgationControl>(
      itemHeight: 40.h,
      dropdownMaxHeight: 150.h,
      dropdownWidth: 290.w,
      buttonPadding: EdgeInsets.only(left: 10.w),
      isExpanded: true,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(right: 10.w, top: 12.w, bottom: 12.w,),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Get.isDarkMode
                ? AppColors.darkText : AppColors.lightBorder,)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Get.isDarkMode
                ? AppColors.darkText : AppColors.lightBorder,)
        ),
        filled: Get.isDarkMode ? true : false,
        fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
      ),
      hint: CustomText(
        text: hintText,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
      ),
      icon: Image.asset(
        AppImages.down,
        height: 20.h,
        width: 20.w,
        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
      ),
      offset: const Offset(0, -20),
      dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      items: itemList.map((e) {
        return DropdownMenuItem(
            value: e,
            child: CustomText(
              text: e.name!,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
            )
        );
      }).toList(),
      onChanged: ( IgationControl? value) {
        selectValue = value!;
        id.value = value.id!;
        AppConst().debug('select value => ${value.id} ${value.name}');
      },
    );
  }
}
