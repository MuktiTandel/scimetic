import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/edit_delete_popup.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/access_setting/controller/access_setting_controller.dart';
import 'package:scimetic/feature/access_setting/model/user_model.dart';

class AccessSettingScreen extends StatelessWidget {
  AccessSettingScreen({Key? key}) : super(key: key);

  final controller = Get.put(AccessSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
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
                    onchange: (value) {
                      if (value.isNotEmpty) {
                        controller.userList.value = controller.userList
                            .where((element) => element.name!.contains(value))
                            .toList();
                      } else {
                        controller.userList.clear();
                        controller.userList.addAll(controller.mainList);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomDropDown(
                  hintText: AppStrings.chooseRole,
                  itemList: controller.chooseRoleList,
                  value: controller.chooseRoleValue.value,
                  isFilled: true,
                  width: 330.w,
                  onChange: (value) {
                    controller.chooseRoleValue.value = value;
                    if (value.contains(AppStrings.superAdmin)) {
                      controller.userList.clear();
                      for (var element in controller.mainList) {
                        if (element.role!.name!
                            .contains(AppStrings.superAdmin)) {
                          controller.userList.add(element);
                        }
                      }
                    } else if (value.contains(AppStrings.companyOwner)) {
                      controller.userList.clear();
                      for (var element in controller.mainList) {
                        if (element.role!.name!
                            .contains(AppStrings.companyOwner)) {
                          controller.userList.add(element);
                        }
                      }
                    } else if (value.contains(AppStrings.companyAdmin)) {
                      controller.userList.clear();
                      for (var element in controller.mainList) {
                        if (element.role!.name!
                            .contains(AppStrings.companyAdmin)) {
                          controller.userList.add(element);
                        }
                      }
                    } else {
                      controller.userList.clear();
                      for (var element in controller.mainList) {
                        if (element.role!.name!
                            .contains(AppStrings.cropTechnician)) {
                          controller.userList.add(element);
                        }
                      }
                    }
                  },
                  isEdit: false.obs,
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
                            onTap: () async {
                              // await controller.deleteGrowSheet();
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
                    Obx(
                      () => controller.isGetData.value == true
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.userList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return listWidget(
                                    isSelect: controller.selectList[index],
                                    data: controller.userList[index],
                                    isShow: controller.showList[index]);
                              })
                          : const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.buttonColor,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: CustomButton(
                        height: 30.h,
                        width: 85.w,
                        onTap: () {
                          Get.dialog(dialogWidget());
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
      {required RxBool isSelect, required User data, required RxBool isShow}) {

    // AccessSettingController.encryptAES("Password@123");
    //
    // AccessSettingController.decryptAES(data.password!);
    //
    // controller.getPassword(data.password!);

    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        isSelect.value = !isSelect.value;
                        controller.isSelect.value = false;
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
                  CircleAvatar(
                    maxRadius: 20.h,
                    backgroundImage: const AssetImage(AppImages.group15),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: data.name ?? "",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonColor,
                            ),
                            Expanded(
                                child: SizedBox(
                              width: 10.w,
                            )),
                            editDeletePopup(
                                editTap: () {
                              controller.isEdit.value = true;

                              controller.userId.value = data.id ?? 0;

                              String? firstName;
                              String? lastName;

                              if (data.name!.contains(' ')) {
                                var name = data.name!.split(" ");

                                firstName = name[0];
                                lastName = name[1];
                              }

                              controller.firstNameController.text =
                                  firstName ?? "";
                              controller.lastNameController.text =
                                  lastName ?? "";
                              controller.emailController.text =
                                  data.email ?? "";
                              controller.roleValue.value =
                                  data.role!.name ?? "";

                              Future.delayed(const Duration(seconds: 1), () {
                                Get.dialog(dialogWidget());
                              });
                            },
                              deleteTap: (){}
                            )
                          ],
                        ),
                        CustomText(
                          text: data.email ?? "",
                          color: Get.isDarkMode
                              ? Colors.white
                              : AppColors.subTitleColor,
                          fontSize: 14.sp,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImages.tag,
                    height: 15.h,
                    width: 15.w,
                    color:
                        Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CustomText(
                    text: data.role!.name ?? "",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImages.key,
                    height: 18.h,
                    width: 18.w,
                    color: Get.isDarkMode
                        ? AppColors.darkText
                        : AppColors.lightBorder,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Obx(() => TextFormField(
                          controller: controller.keyController,
                          readOnly: true,
                          obscureText: isShow.value,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : AppColors.subTitleColor,
                              fontFamily: "Poppins",
                              letterSpacing: 2.w,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Obx(() => GestureDetector(
                                    onTap: () {
                                      isShow.value = !isShow.value;
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Image.asset(
                                        isShow.value == false
                                            ? AppImages.visible
                                            : AppImages.unVisible,
                                        height: 15.h,
                                        width: 15.w,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : AppColors.subTitleColor,
                                      ),
                                    ),
                                  ))),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  Widget dialogWidget() {
    return CommonDialogWidget(
      title: AppStrings.addNewUser,
      widget: SizedBox(
        width: 350.w,
        child: Padding(
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
              CustomText(
                text: AppStrings.firstName,
                color:
                    Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 12.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 40.h,
                child: CustomTextField(
                  controller: controller.firstNameController,
                  borderRadius: 8,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  hintText: AppStrings.firstName_,
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
                text: AppStrings.lastName,
                color:
                    Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 12.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 40.h,
                child: CustomTextField(
                  controller: controller.lastNameController,
                  borderRadius: 8,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  hintText: AppStrings.lastName_,
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
                text: AppStrings.email,
                color:
                    Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 12.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 40.h,
                child: CustomTextField(
                  controller: controller.emailController,
                  borderRadius: 8,
                  contentPadding: EdgeInsets.only(left: 10.w),
                  hintText: AppStrings.enterEmail,
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
                text: AppStrings.role,
                color:
                    Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 12.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomDropDown(
                hintText: AppStrings.chooseRole,
                itemList: controller.chooseRoleList,
                value: controller.roleValue.value,
                isFilled: false,
                width: 300.w,
                onChange: (value) {
                  controller.roleValue.value = value;
                  if ( value.contains(AppStrings.superAdmin) ) {
                    controller.roleCode.value = "super_admin";
                  } else if ( value.contains(AppStrings.companyOwner) ) {
                    controller.roleCode.value = "company_owner";
                  } else if ( value.contains(AppStrings.companyAdmin) ) {
                    controller.roleCode.value = "company_admin";
                  } else if ( value.contains(AppStrings.cropTechnician) ) {
                    controller.roleCode.value = "crop_technician";
                  }
                },
                isEdit: controller.isEdit,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomText(
                text: AppStrings.setPersonalPin,
                color:
                    Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 12.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 40.h,
                child: Obx(() => CustomTextField(
                      isObscure: controller.isPinShow.value,
                      controller: controller.pinController,
                      borderRadius: 8,
                      contentPadding: EdgeInsets.only(left: 10.w),
                      hintText: AppStrings.setPersonalPin,
                      hintTextSize: 12.sp,
                      suffixWidget: GestureDetector(
                        onTap: () {
                          controller.isPinShow.value =
                              !controller.isPinShow.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Image.asset(
                            controller.isPinShow.value == false
                                ? AppImages.visible
                                : AppImages.unVisible,
                            height: 15.h,
                            width: 15.w,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.subTitleColor,
                          ),
                        ),
                      ),
                      focusBorderColor: AppColors.buttonColor,
                      isFilled: Get.isDarkMode ? true : false,
                      onchange: (value) {},
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                onTap: () {
                  controller.onSave();
                },
                buttonText: AppStrings.save,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        controller.firstNameController.clear();
        controller.lastNameController.clear();
        controller.emailController.clear();
        controller.pinController.clear();
        controller.isValid.value = true;
        Get.back();
      },
    );
  }
}
