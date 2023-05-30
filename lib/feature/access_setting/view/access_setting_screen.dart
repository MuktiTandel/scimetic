import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/edit_delete_popup.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/access_setting/controller/access_setting_controller.dart';

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
                  hintText: AppStrings.chooseRole,
                  itemList: controller.chooseRoleList,
                  value: controller.chooseRoleValue.value,
                  isFilled: false,
                  width: 330.w,
                  onChange: (value) {
                    controller.chooseRoleValue.value = value;
                  },
                ),
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
                                title: AppStrings.addNewUser,
                                widget: SizedBox(
                                  width: 350.w,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.firstName,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
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
                                            onchange: (value){},
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        CustomText(
                                          text: AppStrings.lastName,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
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
                                            onchange: (value){},
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        CustomText(
                                          text: AppStrings.email,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
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
                                            onchange: (value){},
                                          ),
                                        ),
                                        SizedBox(height: 10.h,),
                                        CustomText(
                                          text: AppStrings.role,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
                                        CustomDropDown(
                                          hintText: AppStrings.chooseRole,
                                          itemList: controller.roleList,
                                          value: controller.roleValue.value,
                                          isFilled: false,
                                          width: 300.w,
                                          onChange: (value) {
                                            controller.roleValue.value = value;
                                          },
                                        ),
                                        SizedBox(height: 10.h,),
                                        CustomText(
                                          text: AppStrings.setPersonalPin,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
                                        SizedBox(
                                          height: 40.h,
                                          child: Obx(() => CustomTextField(
                                            isObscure: controller.isPinShow.value,
                                            controller: controller.pinController,
                                            textInputType: TextInputType.number,
                                            borderRadius: 8,
                                            contentPadding: EdgeInsets.only(left: 10.w),
                                            hintText: AppStrings.setPersonalPin,
                                            hintTextSize: 12.sp,
                                            suffixWidget: GestureDetector(
                                              onTap: (){
                                                controller.isPinShow.value = !controller.isPinShow.value;
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(10.w),
                                                child: Image.asset(
                                                  controller.isPinShow.value == false ? AppImages.visible : AppImages.unVisible,
                                                  height: 15.h,
                                                  width: 15.w,
                                                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                                                ),
                                              ),
                                            ),
                                            focusBorderColor: AppColors.buttonColor,
                                            isFilled: Get.isDarkMode ? true : false,
                                            onchange: (value){},
                                          )),
                                        ),
                                        SizedBox(height: 10.h,),
                                        CustomButton(
                                            onTap: (){
                                              controller.firstNameController.clear();
                                              controller.lastNameController.clear();
                                              controller.emailController.clear();
                                              controller.pinController.clear();
                                              Get.back();
                                            },
                                            buttonText: AppStrings.save,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 10.h,)
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  controller.firstNameController.clear();
                                  controller.lastNameController.clear();
                                  controller.emailController.clear();
                                  controller.pinController.clear();
                                  Get.back();
                                },
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
                    SizedBox(height: 20.h,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listWidget() {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 20.h,
                    backgroundImage: const AssetImage(AppImages.group15),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Jane Lakers",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonColor,
                            ),
                            Expanded(child: SizedBox(width: 10.w,)),
                            editDeletePopup(editTap: (){})
                          ],
                        ),
                        CustomText(
                          text: "jane.lakers@gmail.com",
                          color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                          fontSize: 14.sp,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h,),
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
                    text: "Technician",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  )
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Image.asset(
                    AppImages.key,
                    height: 18.h,
                    width: 18.w,
                    color: Get.isDarkMode
                        ? AppColors.darkText : AppColors.lightBorder,
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Obx(() => TextFormField(
                      controller: controller.keyController,
                      readOnly: true,
                      obscureText: controller.isObscureText.value,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Get.isDarkMode
                              ? Colors.white : AppColors.subTitleColor,
                          fontFamily: "Poppins",
                          letterSpacing: 2.w,
                          fontWeight: FontWeight.w500
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              controller.isObscureText.value = !controller.isObscureText.value;
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Image.asset(
                                controller.isObscureText.value == false ? AppImages.visible : AppImages.unVisible,
                                height: 15.h,
                                width: 15.w,
                                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                              ),
                            ),
                          )
                      ),
                    )),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
