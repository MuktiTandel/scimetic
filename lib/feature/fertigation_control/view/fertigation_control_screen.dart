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
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/fertigation_control/controller/fertigation_controller.dart';

class FertigationControlScreen extends StatelessWidget {
  FertigationControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(FertigationController());

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
                    onchange: (value) {},
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
                            for (var element in controller.selectList) {
                              element.value = true;
                            }
                          } else {
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
                            onTap: () async {},
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
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return listWidget(
                            isSelect: controller.selectList[index]
                          );
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: CustomButton(
                        height: 30.h,
                        width: 85.w,
                        onTap: () {
                          Get.dialog(CommonDialogWidget(
                              title: AppStrings.addNewSchedules,
                              onTap: () {
                                controller.listHeight.value = 90.0;
                                controller.dayIngredientList.clear();
                                controller.dayIngredientList
                                    .add(TextEditingController());
                                controller.dayQuantityList.clear();
                                controller.dayQuantityList
                                    .add(TextEditingController());
                                controller.nightQuantityList.clear();
                                controller.nightQuantityList
                                    .add(TextEditingController());
                                controller.nightIngredientList.clear();
                                controller.nightIngredientList
                                    .add(TextEditingController());
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
                                        children: [
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
                                          Obx(() => SizedBox(
                                                height:
                                                    controller.listHeight.value,
                                                child: ListView.builder(
                                                    itemCount: controller
                                                        .dayIngredientList
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return commonIrrigationWidget(
                                                          count: index + 1,
                                                          ingredientController:
                                                              controller
                                                                      .dayIngredientList[
                                                                  index],
                                                          quantityController:
                                                              controller
                                                                      .dayQuantityList[
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
                                      color: Get.isDarkMode
                                          ? AppColors.darkTheme
                                          : AppColors.lightAppbar,
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
                                          Obx(() => SizedBox(
                                                height:
                                                    controller.listHeight.value,
                                                child: ListView.builder(
                                                    itemCount: controller
                                                        .nightIngredientList
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return commonIrrigationWidget(
                                                          count: index + 1,
                                                          ingredientController:
                                                              controller
                                                                      .nightIngredientList[
                                                                  index],
                                                          quantityController:
                                                              controller
                                                                      .nightQuantityList[
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
                                                      82.0;
                                              controller.dayIngredientList
                                                  .add(TextEditingController());
                                              controller.dayQuantityList
                                                  .add(TextEditingController());
                                              controller.nightIngredientList
                                                  .add(TextEditingController());
                                              controller.nightQuantityList
                                                  .add(TextEditingController());
                                            },
                                            buttonText: AppStrings.addFormula),
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
                                            CustomText(
                                              text: AppStrings.name,
                                              color: Get.isDarkMode
                                                  ? AppColors.darkText
                                                  : AppColors.lightText,
                                              fontSize: 12.h,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              height: 40.h,
                                              child: CustomTextField(
                                                controller:
                                                    controller.nameController,
                                                borderRadius: 8,
                                                contentPadding:
                                                    EdgeInsets.only(left: 10.w),
                                                hintText: AppStrings.name,
                                                hintTextSize: 12.sp,
                                                focusBorderColor:
                                                    AppColors.buttonColor,
                                                isFilled: Get.isDarkMode
                                                    ? true
                                                    : false,
                                                onchange: (value) {},
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomText(
                                              text: AppStrings.tag,
                                              color: Get.isDarkMode
                                                  ? AppColors.darkText
                                                  : AppColors.lightText,
                                              fontSize: 12.h,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              height: 40.h,
                                              child: CustomTextField(
                                                controller:
                                                    controller.tagController,
                                                borderRadius: 8,
                                                contentPadding:
                                                    EdgeInsets.only(left: 10.w),
                                                hintText: AppStrings.tag,
                                                hintTextSize: 12.sp,
                                                focusBorderColor:
                                                    AppColors.buttonColor,
                                                isFilled: Get.isDarkMode
                                                    ? true
                                                    : false,
                                                onchange: (value) {},
                                              ),
                                            ),
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
                                            SizedBox(
                                              height: 20.h,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )));
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

  Widget listWidget({required RxBool isSelect}) {
    return Container(
      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    isSelect.value = !isSelect.value;
                    controller.isSelect.value = !controller.isSelect.value;
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
                text: AppStrings.formulaName,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              Expanded(
                  child: SizedBox(
                width: 10.w,
              )),
              commonPopup(
                  deleteTap: () {},
                  applyTap: () {},
                  isApply: controller.isApply,
                  editTap: () {}),
              SizedBox(
                width: 10.w,
              ),
              Obx(() => GestureDetector(
                    onTap: () {
                      controller.isSelect.value = !controller.isSelect.value;
                    },
                    child: Image.asset(
                      controller.isSelect.value == false
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
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomText(
                text: AppStrings.seedling,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            AppStrings.tODesc,
            style: TextStyleDecoration.body1,
          ),
          Obx(() => controller.isSelect.value == true
              ? SizedBox(
                  height: 10.h,
                )
              : const SizedBox.shrink()),
          Obx(() => controller.isSelect.value == true
              ? Column(
                  children: [
                    commonIngredientWidget(title: AppStrings.day),
                    SizedBox(
                      height: 10.h,
                    ),
                    commonIngredientWidget(title: AppStrings.night),
                  ],
                )
              : const SizedBox.shrink())
        ],
      ),
    );
  }

  Widget commonIngredientWidget({required String title}) {
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
              itemCount: 8,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return detailWidget(count: index + 1);
              })
        ],
      ),
    );
  }

  Widget detailWidget({required int count}) {
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
              text: "Ingredient name",
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 13.sp,
            ),
            Expanded(
                child: SizedBox(
              width: 10.w,
            )),
            CustomText(
              text: "520ml",
              color:
                  Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
              fontSize: 13.sp,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }

  Widget commonIrrigationWidget(
      {required int count,
      required TextEditingController ingredientController,
      required TextEditingController quantityController}) {
    return Column(
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
                  text: AppStrings.ingredient,
                  color:
                      Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  fontSize: 12.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 40.h,
                  width: 130.w,
                  child: CustomTextField(
                    controller: ingredientController,
                    borderRadius: 8,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    hintText: AppStrings.ingredient,
                    hintTextSize: 12.sp,
                    focusBorderColor: AppColors.buttonColor,
                    isFilled: Get.isDarkMode ? true : false,
                    onchange: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.quantity,
                  color:
                      Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  fontSize: 12.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 40.h,
                  width: 100.w,
                  child: CustomTextField(
                    controller: quantityController,
                    borderRadius: 8,
                    textInputType: TextInputType.number,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    hintText: "",
                    hintTextSize: 12.sp,
                    focusBorderColor: AppColors.buttonColor,
                    isFilled: Get.isDarkMode ? true : false,
                    suffixWidget: Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 10.w),
                      child: CustomText(
                        text: "ml",
                        fontSize: 13.sp,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.subTitleColor,
                      ),
                    ),
                    onchange: (value) {},
                  ),
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
}
