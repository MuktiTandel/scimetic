import 'package:dotted_border/dotted_border.dart';
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
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/organization_settings/controller/organization_setting_controller.dart';

class OrganizationSettingScreen extends StatelessWidget {
   OrganizationSettingScreen({Key? key}) : super(key: key);

  final controller = Get.put(OrganizationSettingController());

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
                    text: AppStrings.companyLogo,
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
                                ? Image.asset(
                              AppImages.logo,
                              height: 43.h,
                              width: 43.w,
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
                    Expanded(child: SizedBox(width: 10.w,)),
                    CustomButton(
                      width: 85.w,
                        height: 30.h,
                        backgroundColor: Get.isDarkMode
                            ? Colors.white : AppColors.subTitleColor,
                        buttonTextColor: Get.isDarkMode
                            ? AppColors.subTitleColor : Colors.white ,
                        onTap: (){},
                        buttonText: AppStrings.upload
                    ),
                    SizedBox(width: 10.w,),
                    OutLineButton(
                      height: 30.h,
                      width: 100.w,
                      onTap: (){},
                      color: AppColors.red,
                      buttonText: AppStrings.remove,
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.organizationName,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.organizationNameController,
                  borderRadius: 8,
                  hintText: AppStrings.enterOrganizationName,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.address,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.addressController,
                  borderRadius: 8,
                  hintText: AppStrings.enterAddress,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.companyRegistrationNo,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.registrationNoController,
                  borderRadius: 8,
                  hintText: AppStrings.enterRegistrationNo,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 15.h,),
                CustomText(
                  text: AppStrings.licenseNumber,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.licenseNoController,
                  borderRadius: 8,
                  hintText: AppStrings.enterLicenseNumber,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 20.h,),
                CustomText(
                  text: AppStrings.contactInformation,
                  color: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightBorder,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 10.h,),
                CustomText(
                  text: AppStrings.mobileNumber,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                IntlPhoneField(
                  controller: controller.mobileNoController,
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
                  text: AppStrings.website,
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  controller: controller.websiteController,
                  borderRadius: 8,
                  hintText: AppStrings.websiteCom,
                  hintTextSize: 12.sp,
                  focusBorderColor: AppColors.buttonColor,
                  isFilled: Get.isDarkMode ? true : false,
                  onchange: (value){},
                ),
                SizedBox(height: 20.h,),
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
                        onTap: (){},
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
