import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/text_style_decoration.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({Key? key}) : super(key: key);

   final controller = Get.put(DashboardController());

   final overViewController = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: AppBehavior(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 15.h,),
            Obx(() =>  controller.isGetData.value == false ? const Center(
             child: CircularProgressIndicator(
               color: AppColors.buttonColor,
             ),
           ) : ListView.builder(
               padding: EdgeInsets.zero,
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: controller.dataList.length,
               itemBuilder: (BuildContext context, int index) {

                 GrowController data = controller.dataList[index];

                 return listWidget(
                     onTap: (){
                       controller.isOverView.value = true;
                       controller.isSelect.value = true;
                       overViewController.id.value = data.id!;
                       overViewController.getClimateData(identifier: data.identifier!).whenComplete(() {
                         overViewController.getGrowSheetData(id: data.id!).whenComplete(() {
                           overViewController.getDeviceData(id: data.id!);
                         });
                       });
                       controller.storeData.setData(StoreData.id, data.id!);
                     },
                     context: context,
                     title: data.name ?? "",
                     desc: data.description ?? "",
                   editTap: (){

                       controller.isEdit.value = true;
                       controller.growspaceNameController.text = data.name!;
                       controller.locationController.text = "${data.latitude
                           .toString()},${data.longitude.toString()}";
                       controller.serialNumberController.text = data.identifier!;
                       controller.descriptionController.text = data.description!;

                       if ( data.dayStart!.isNotEmpty ) {
                         final dayStart = data.dayStart!;

                         AppConst().debug(dayStart);

                         final split = dayStart.split(":");

                         final Map<int, String> values = {
                           for (int i = 0; i < split.length; i++)
                             i: split[i]
                         };

                         AppConst().debug('${values[0]}');

                         controller.dayHourController.text = values[0]!;
                         controller.dayMinuteController.text = values[1]!;
                       }

                       if ( data.nightStart!.isNotEmpty ) {
                         final nightStart = data.nightStart!;

                         final split1 = nightStart.split(":");

                         final Map<int, String> values1 = {
                           for (int i = 0; i < split1.length; i++)
                             i: split1[i]
                         };

                         controller.nightHourController.text = values1[0]!;
                         controller.nightMinuteController.text = values1[1]!;
                       }

                       Future.delayed(const Duration(microseconds: 5000), (){
                         Get.dialog(
                          dialog()
                         );
                       });
                   }
                 );
               }),),
            SizedBox(height: 10.h,),
            Padding(
              padding:  EdgeInsets.only(right: 18.w),
              child: CustomButton(
                height: 30.h,
                width: 85.w,
                onTap: (){
                  Get.dialog(
                    dialog()
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
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }

  Widget listWidget({
    required VoidCallback onTap,
    required BuildContext context,
    required String title,
    required String desc,
    required VoidCallback editTap
  }) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
            color: context.theme.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyleDecoration.headline5,
                    ),
                    PopupMenuButton<int>(
                      offset: Offset(0, 17.h),
                      padding: EdgeInsets.zero,
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      constraints: BoxConstraints(
                          maxWidth: 115.w,
                          maxHeight: 75.h
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
                            onTap: (){
                              editTap();
                            },
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
                            value: 1,
                            padding: EdgeInsets.zero,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 6.h),
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
                SizedBox(height: 5.h,),
                Text(
                  desc,
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
      ),
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

  Widget dialog() {
    return  CommonDialogWidget(
        title: AppStrings.newGrowspace,
        onTap: (){
          controller.growspaceNameController.clear();
          controller.serialNumberController.clear();
          controller.descriptionController.clear();
          controller.locationController.clear();
          controller.dayHourController.clear();
          controller.dayMinuteController.clear();
          controller.nightHourController.clear();
          controller.nightMinuteController.clear();
        },
        widget: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 6.h),
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
              SizedBox(height: 10.h,),
              CustomText(
                text: AppStrings.growsheetName,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightText,
              ),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 38.h,
                child: CustomTextField(
                  controller: controller.growspaceNameController,
                  isFilled: false,
                  hintText: AppStrings.name,
                  borderRadius: 8,
                  focusBorderColor: AppColors.buttonColor,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  onchange: (value){},
                ),
              ),
              SizedBox(height: 15.h,),
              CustomText(
                text: AppStrings.location,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightText,
              ),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 38.h,
                child: CustomTextField(
                  controller: controller.locationController,
                  isFilled: false,
                  hintText: "00.000000 , 00.000000",
                  borderRadius: 8,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  prefixWidget: Padding(
                    padding: EdgeInsets.only( top: 10.h, bottom: 10.h),
                    child: Image.asset(
                      AppImages.location,
                      height: 10.h,
                      width: 10.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  suffixWidget: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Image.asset(
                      AppImages.map,
                      height: 15.h,
                      width: 15.w,
                    ),
                  ),
                  focusBorderColor: AppColors.buttonColor,
                  onchange: (value){},
                ),
              ),
              SizedBox(height: 15.h,),
              CustomText(
                text: AppStrings.serialNumber,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightText,
              ),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 38.h,
                child: Obx(() => CustomTextField(
                  controller: controller.serialNumberController,
                  isFilled: false,
                  hintText: AppStrings.serialNumber,
                  borderRadius: 8,
                  focusBorderColor: AppColors.buttonColor,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  suffixWidget: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Image.asset(
                      AppImages.done,
                      color: Get.isDarkMode
                          ? AppColors.darkText
                          : controller.isNotEmpty.value == true
                          ? AppColors.buttonColor : AppColors.lightText,
                    ),
                  ),
                  onchange: (value){
                    if ( value.isNotEmpty ) {
                      controller.isNotEmpty.value = true;
                    }
                  },
                )),
              ),
              SizedBox(height: 15.w,),
              CustomText(
                text: AppStrings.description,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightText,
              ),
              SizedBox(height: 6.h,),
              Obx(() => SizedBox(
                  height: 100.h,
                  child: TextFormField(
                    controller: controller.descriptionController,
                    maxLength: 80,
                    maxLines: 50,
                    cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                    style:  TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15.sp,
                        color: Get.isDarkMode ? Colors.white : Colors.black
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
                        borderSide: const BorderSide(
                            color: AppColors.buttonColor
                        ),
                      ),
                      hintText: AppStrings.addDescription,
                      contentPadding: EdgeInsets.all(10.w),
                      hintStyle:  TextStyle(
                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                          fontSize: 14.sp,
                          fontFamily: "Poppins"
                      ),
                      counterText: "${controller.descriptionLength.value}/80",
                      counterStyle: TextStyle(
                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"
                      ),
                    ),
                    onChanged: (value){
                      controller.descriptionLength.value = value.length;
                    },
                  )
              )),
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.dayStart,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? AppColors.darkText : AppColors.lightText,
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          commonTimeTextField(
                              controller: controller.dayHourController,
                              hintText: AppStrings.hh,
                              onChanged: (value) {}
                          ),
                          SizedBox(width: 6.w,),
                          CustomText(
                            text: ":",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? AppColors.darkText
                                : AppColors.subTitleColor,
                          ),
                          SizedBox(width: 6.w,),
                          commonTimeTextField(
                              controller: controller.dayMinuteController,
                              hintText: AppStrings.mm,
                              onChanged: (value) {}
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 15.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.nightStart,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? AppColors.darkText : AppColors.lightText,
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          commonTimeTextField(
                              controller: controller.nightHourController,
                              hintText: AppStrings.hh,
                              onChanged: (value) {}
                          ),
                          SizedBox(width: 6.w,),
                          CustomText(
                            text: ":",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? AppColors.darkText
                                : AppColors.subTitleColor,
                          ),
                          SizedBox(width: 6.w,),
                          commonTimeTextField(
                              controller: controller.nightMinuteController,
                              hintText: AppStrings.mm,
                              onChanged: (value) {}
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              CustomButton(
                onTap: (){
                  controller.onSave();
                },
                buttonText: AppStrings.save,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ));
  }
}
