import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_image_picker_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/profile_setting/controller/profile_setting_controller.dart';

class ProfileSettingScreen extends StatelessWidget {
   ProfileSettingScreen({Key? key}) : super(key: key);

   final controller = Get.put(ProfileSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.mainInfo,
                  color: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightBorder,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 8.h,),
                CustomText(
                  text: AppStrings.userPhoto,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return commonImagePickerWidget(
                                  cameraTap: (){
                                    Get.back();
                                    controller.getFromCamera();
                                  },
                                  galleryTap: (){
                                    Get.back();
                                    controller.getFromGallery();
                                  }
                              );
                            }
                        );
                      },
                      child: CircleAvatar(
                        maxRadius: 34.h,
                        backgroundColor: AppColors.lightBorder,
                        child: Container(
                          height: 66.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Center(
                            child: Obx(() =>  controller.isPick.value == false
                                ? controller.imageUrl.value.isEmpty ? Image.asset(
                              AppImages.logo,
                              height: 43.h,
                              width: 43.w,
                            ) : ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(39),
                                child: Image.network(
                                  controller.imageUrl.value,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, expection, stackTrace){
                                    return Image.asset(
                                      AppImages.logo,
                                      height: 40.h,
                                      width: 40.w,
                                    );
                                  },
                                ),
                              ),
                            ) : ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(39),
                                child: Image.file(
                                  controller.imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    CustomButton(
                        width: 85.w,
                        height: 30.h,
                        backgroundColor: Get.isDarkMode
                            ? Colors.white : AppColors.subTitleColor,
                        buttonTextColor: Get.isDarkMode
                            ? AppColors.subTitleColor : Colors.white ,
                        onTap: (){
                          if ( controller.imageFile != null ) {
                            controller.uploadImage();
                          } else {
                            showSnack(title: AppStrings.pCImage, width: 250.w);
                          }
                        },
                        buttonText: AppStrings.upload
                    ),
                    // SizedBox(width: 10.w,),
                    // OutLineButton(
                    //   height: 30.h,
                    //   width: 100.w,
                    //   onTap: (){},
                    //   color: AppColors.red,
                    //   buttonText: AppStrings.remove,
                    // )
                  ],
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.firstName,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.firstNameController,
                  borderRadius: 8,
                  hintText: AppStrings.firstName,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.lastName,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.lastNameController,
                  borderRadius: 8,
                  hintText: AppStrings.lastName,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.email,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.emailController,
                  borderRadius: 8,
                  hintText: AppStrings.enterEmail,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.mobileNumber,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                IntlPhoneField(
                  controller: controller.mobileNumberController,
                  cursorColor: Get.isDarkMode
                      ? AppColors.darkText : AppColors.lightText,
                  flagsButtonPadding: const EdgeInsets.all(8),
                  dropdownIconPosition: IconPosition.trailing,
                  dropdownTextStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15.sp,
                    color: Get.isDarkMode
                        ? AppColors.darkText : AppColors.lightText,
                  ),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  dropdownIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
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
                      counter: const SizedBox.shrink(),
                      fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
                      filled: Get.isDarkMode ? true : false
                  ),
                  initialCountryCode: 'IN',
                  disableLengthCheck: false,
                  autovalidateMode: AutovalidateMode.disabled,
                  onChanged: (phone) {
                  },
                ),
                SizedBox(height: 20.h,),
                CustomText(
                  text: AppStrings.securitySettings,
                  color: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightBorder,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 20.h,),
                CustomText(
                  text: AppStrings.recoveryEmail,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.recoveryEmailController,
                  borderRadius: 8,
                  hintText: AppStrings.recoveryEmail,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutLineButton(
                      onTap: (){},
                      color: AppColors.red,
                      buttonText: AppStrings.cancel,
                      height: 30.h,
                    ),
                    SizedBox(width: 15.w,),
                    CustomButton(
                        width: 100.w,
                        height: 30.h,
                        fontSize: 14.sp,
                        onTap: (){
                          controller.updateProfile();
                        },
                        buttonText: AppStrings.save
                    )
                  ],
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
