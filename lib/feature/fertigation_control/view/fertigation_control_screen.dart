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
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/fertigation_control/controller/fertigation_controller.dart';
import 'package:scimetic/feature/fertigation_control/model/fertigation_model.dart';

class FertigationControlScreen extends StatelessWidget {
  FertigationControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(FertigationController());

  final dashboardController = Get.put(DashboardController());

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
                CustomDropDown(
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
                    await controller.getFertigationControlData();
                  },
                  isEdit: false.obs,
                  isEnable: false,
                ),
                SizedBox(height: 10.h,),
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
                    onchange: (value) {
                      if (value.isNotEmpty) {
                        controller.fertigationList.value = controller
                            .fertigationList
                            .where((element) => element.name!.contains(value))
                            .toList();
                      } else {
                        controller.fertigationList.clear();
                        controller.fertigationList.addAll(controller.mainList);
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
                          controller.fertigationControlIds.clear();
                          if (controller.isCheckAll.value == true) {
                            controller.isSelect.value = true;
                            for (var element in controller.selectList) {
                              element.value = true;
                            }
                            for (var element in controller.fertigationList) {
                              controller.fertigationControlIds.add(element.id);
                            }
                          } else {
                            controller.isSelect.value = false;
                            controller.fertigationControlIds.clear();
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
                              controller.fertigationControlIds.clear();
                              for (int i = 0;
                                  i < controller.selectList.length;
                                  i++) {
                                bool isSelect = controller.selectList[i].value;
                                if (isSelect == true) {
                                  FertigationControl data =
                                      controller.fertigationList[i];
                                  controller.fertigationControlIds
                                      .add(data.id!);
                                }
                              }
                              AppConst().debug(
                                  'id list => ${controller.fertigationControlIds}');
                              await controller
                                  .deleteFertigationControl()
                                  .whenComplete(() async {
                                await controller.getFertigationControlData();
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
                            itemCount: controller.fertigationList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return listWidget(
                                  isSelect: controller.selectList[index],
                                  isShow: controller.showList[index],
                                  data: controller.fertigationList[index],
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
                          Get.dialog(dialogWidget(context: context));
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
      {required RxBool isSelect,
      required RxBool isShow,
      required FertigationControl data,
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
                            controller.fertigationControlIds.clear();
                            controller.fertigationControlIds.add(data.id!);
                            await controller
                                .deleteFertigationControl()
                                .whenComplete(() async {
                              await controller.getFertigationControlData();
                            });
                          },
                          applyTap: () async {
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
                          isApply: isApplied,
                          editTap: () {
                            controller.isEdit.value = true;
                            controller.fertigationId.value = data.id ?? 0;
                            controller.listHeight.value = 90.0;

                            controller.nameController.text = data.name ?? "";
                            controller.tagController.text = data.tag ?? "";
                            controller.descriptionController.text =
                                data.description ?? "";

                            if (data.formulas!.isNotEmpty) {
                              controller.dayIngredientList.clear();
                              controller.dayQuantityList.clear();
                              controller.nightIngredientList.clear();
                              controller.nightQuantityList.clear();

                              for (int i = 0; i < data.formulas!.length; i++) {
                                controller.listHeight.value =
                                    controller.listHeight.value + 80.0;
                                controller.dayIngredientList
                                    .add(TextEditingController());
                                controller.dayQuantityList
                                    .add(TextEditingController());
                                controller.nightIngredientList
                                    .add(TextEditingController());
                                controller.nightQuantityList
                                    .add(TextEditingController());
                                Formula formula = Formula();
                                controller.dayIngredientList[i].text =
                                    formula.dayIngredient ?? "";
                                controller.dayQuantityList[i].text =
                                    formula.dayQuantity ?? "";
                                controller.nightIngredientList[i].text =
                                    formula.nightIngredient ?? "";
                                controller.nightQuantityList[i].text =
                                    formula.nightQuantity ?? "";
                              }

                              for (int i = 0; i < data.formulas!.length; i++) {
                                Formula formula = data.formulas![i];
                                controller.dayIngredientList[i].text =
                                    formula.dayIngredient ?? "";
                                controller.dayQuantityList[i].text =
                                    formula.dayQuantity ?? "";
                                controller.nightIngredientList[i].text =
                                    formula.nightIngredient ?? "";
                                controller.nightQuantityList[i].text =
                                    formula.nightQuantity ?? "";
                              }
                            }

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              Get.dialog(dialogWidget(context: Get.context!));
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
                      ? Column(
                          children: [
                            commonIngredientWidget(
                                title: AppStrings.day,
                                isDay: true,
                                formulaList: data.formulas ?? []),
                            SizedBox(
                              height: 10.h,
                            ),
                            commonIngredientWidget(
                                title: AppStrings.night,
                                isDay: false,
                                formulaList: data.formulas ?? []),
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

  Widget commonIngredientWidget(
      {required String title,
      required List<Formula> formulaList,
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
              itemCount: formulaList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return detailWidget(
                  count: index + 1,
                  ingredient: isDay == true
                      ? formulaList[index].dayIngredient ?? ""
                      : formulaList[index].nightIngredient ?? "",
                  quantity: isDay == true
                      ? formulaList[index].dayQuantity ?? ""
                      : formulaList[index].nightQuantity ?? "",
                );
              })
        ],
      ),
    );
  }

  Widget detailWidget(
      {required int count,
      required String ingredient,
      required String quantity}) {
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
              text: ingredient,
              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 13.sp,
            ),
            Expanded(
                child: SizedBox(
              width: 10.w,
            )),
            CustomText(
              text: "${quantity}ml",
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

  Widget dialogWidget({required BuildContext context}) {
    return CommonDialogWidget(
        title: AppStrings.addNewSchedules,
        onTap: () {
          controller.listHeight.value = 90.0;
          controller.dayIngredientList.clear();
          controller.dayIngredientList.add(TextEditingController());
          controller.dayQuantityList.clear();
          controller.dayQuantityList.add(TextEditingController());
          controller.nightQuantityList.clear();
          controller.nightQuantityList.add(TextEditingController());
          controller.nightIngredientList.clear();
          controller.nightIngredientList.add(TextEditingController());
          Get.back();
          for (var element in controller.dayIngredientList) {
            element.clear();
          }
          for (var element in controller.dayQuantityList) {
            element.clear();
          }
          for (var element in controller.nightIngredientList) {
            element.clear();
          }
          for (var element in controller.nightQuantityList) {
            element.clear();
          }
          controller.nameController.clear();
          controller.tagController.clear();
          controller.descriptionController.clear();
        },
        widget: SizedBox(
          width: 350.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.isValid.value == true
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              commonErrorWidget(
                                  onTap: () {
                                    controller.isValid.value = true;
                                  },
                                  errorMessage: controller.errorMessage.value),
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
                          text: AppStrings.dayFertigationMode,
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
                          height: controller.listHeight.value,
                          child: ListView.builder(
                              itemCount: controller.dayIngredientList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return commonIrrigationWidget(
                                    count: index + 1,
                                    ingredientController:
                                        controller.dayIngredientList[index],
                                    quantityController:
                                        controller.dayQuantityList[index]);
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
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                          text: AppStrings.nightFertigationMode,
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
                          height: controller.listHeight.value,
                          child: ListView.builder(
                              itemCount: controller.nightIngredientList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return commonIrrigationWidget(
                                    count: index + 1,
                                    ingredientController:
                                        controller.nightIngredientList[index],
                                    quantityController:
                                        controller.nightQuantityList[index]);
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
                            controller.listHeight.value + 90.0;
                        controller.dayIngredientList
                            .add(TextEditingController());
                        controller.dayQuantityList.add(TextEditingController());
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
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          controller: controller.nameController,
                          borderRadius: 8,
                          contentPadding: EdgeInsets.only(left: 10.w),
                          hintText: AppStrings.name,
                          hintTextSize: 12.sp,
                          focusBorderColor: AppColors.buttonColor,
                          isFilled: Get.isDarkMode ? true : false,
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
                          controller: controller.tagController,
                          borderRadius: 8,
                          contentPadding: EdgeInsets.only(left: 10.w),
                          hintText: AppStrings.tag,
                          hintTextSize: 12.sp,
                          focusBorderColor: AppColors.buttonColor,
                          isFilled: Get.isDarkMode ? true : false,
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
                          controller: controller.descriptionController,
                          descriptionLength: controller.descriptionLength),
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
                                controller.onSave();
                                FocusScope.of(context).unfocus();
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
