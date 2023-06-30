import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/access_setting/controller/access_setting_controller.dart';
import 'package:scimetic/feature/access_setting/view/access_setting_screen.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/dashboard/view/dashboard_screen.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';
import 'package:scimetic/feature/organizations/controller/organization_controller.dart';
import 'package:scimetic/feature/organizations/model/company_model.dart';

class OrganizationScreen extends StatelessWidget {
  OrganizationScreen({Key? key}) : super(key: key);

  final controller = Get.put(OrganizationController());

  final dashBoardController = Get.put(DashboardController());

  final accessSettingController = Get.put(AccessSettingController());

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isGrowSpaces.value == false
        ? Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.w),
                  child: SizedBox(
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
                          controller.dataList.value = controller.dataList
                              .where((element) => element.name!.contains(value))
                              .toList();
                        } else {
                          controller.dataList.clear();
                          controller.dataList.addAll(controller.mainList);
                        }
                      },
                    ),
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
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.dataList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Company data = controller.dataList[index];

                                    return listWidget(
                                        onTap: () async {
                                          controller.isSelect.value = true;
                                          homeController.isOrganization.value =
                                              false;
                                          homeController.isDashboard.value =
                                              true;
                                          dashBoardController.companyName
                                              .value = data.name ?? "";
                                          controller.storeData.setData(
                                              StoreData.companyId, data.id);
                                          await dashBoardController
                                              .getDataList();
                                        },
                                        name: data.name ?? "",
                                        totalGrowSpaces:
                                            data.growspaces!.total ?? 0,
                                        totalControllers:
                                            data.controllers!.total ?? 0,
                                        totalSensors: data.sensors!.total ?? 0,
                                        totalAdmins: data.admins ?? 0,
                                        totalTechnicians: data.technicians ?? 0,
                                        growSpaceOnline:
                                            data.growspaces!.online ?? 0,
                                        growSpaceOffline:
                                            data.growspaces!.offline ?? 0,
                                        controllersOnline:
                                            data.controllers!.online ?? 0,
                                        controllersOffline:
                                            data.controllers!.offline ?? 0,
                                        sensorOffline:
                                            data.sensors!.offline ?? 0,
                                        sensorOnline: data.sensors!.online ?? 0,
                                        onDelete: () async {
                                          await controller
                                              .deleteOrganization(id: data.id!)
                                              .whenComplete(() async {
                                            await controller.getDataList();
                                          });
                                        });
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
                            padding: EdgeInsets.only(right: 18.w),
                            child: CustomButton(
                              height: 30.h,
                              width: 85.w,
                              onTap: () {
                                Get.dialog(CommonDialogWidget(
                                  title: AppStrings.newOrganization,
                                  onTap: () {
                                    controller.organizationNameController
                                        .clear();
                                    controller.addressController.clear();
                                    controller.websiteController.clear();
                                    controller.emailController.clear();
                                    controller.mobileNumberController.clear();
                                    controller.licenseNumberController.clear();
                                    controller.registrationController.clear();
                                    Get.back();
                                  },
                                  widget: SizedBox(
                                    width: 330.w,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(() => controller.isValid.value ==
                                                  true
                                              ? const SizedBox.shrink()
                                              : commonErrorWidget(
                                                  onTap: () {
                                                    controller.isValid.value =
                                                        true;
                                                  },
                                                  errorMessage: controller
                                                      .errorMessage.value)),
                                          Obx(
                                            () => controller.isValid.value ==
                                                    false
                                                ? SizedBox(
                                                    height: 10.h,
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                          CustomText(
                                            text: AppStrings.mainInformation,
                                            color: Get.isDarkMode
                                                ? AppColors.darkIcon
                                                : AppColors.lightBorder,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.organizationName,
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
                                              controller: controller
                                                  .organizationNameController,
                                              borderRadius: 8,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText:
                                                  AppStrings.organizationName,
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.address,
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
                                                  controller.addressController,
                                              borderRadius: 8,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText: AppStrings.address,
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          CustomText(
                                            text: AppStrings
                                                .companyRegistrationNo,
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
                                              controller: controller
                                                  .registrationController,
                                              borderRadius: 8,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText: AppStrings
                                                  .companyRegistrationNo,
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.licenseNumber,
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
                                              controller: controller
                                                  .licenseNumberController,
                                              borderRadius: 8,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText:
                                                  AppStrings.licenseNumber,
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.contactInformation,
                                            color: Get.isDarkMode
                                                ? AppColors.darkIcon
                                                : AppColors.lightBorder,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.mobileNumber,
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
                                              controller: controller
                                                  .mobileNumberController,
                                              borderRadius: 8,
                                              textInputType:
                                                  TextInputType.number,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText: AppStrings.mobileNumber,
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.email,
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
                                                  controller.emailController,
                                              borderRadius: 8,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText: AppStrings.email,
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.website,
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
                                                  controller.websiteController,
                                              borderRadius: 8,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              hintText:
                                                  "http://www.example.com",
                                              hintTextSize: 12.sp,
                                              focusBorderColor:
                                                  AppColors.buttonColor,
                                              isFilled:
                                                  Get.isDarkMode ? true : false,
                                              onchange: (value) {},
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutLineButton(
                                                  onTap: () {
                                                    controller
                                                        .organizationNameController
                                                        .clear();
                                                    controller.addressController
                                                        .clear();
                                                    controller.websiteController
                                                        .clear();
                                                    controller.emailController
                                                        .clear();
                                                    controller
                                                        .mobileNumberController
                                                        .clear();
                                                    controller
                                                        .licenseNumberController
                                                        .clear();
                                                    controller
                                                        .registrationController
                                                        .clear();
                                                    Get.back();
                                                  },
                                                  color: AppColors.red,
                                                  buttonText: AppStrings.cancel,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: CustomButton(
                                                  onTap: () {
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
                                            height: 10.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
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
                )
              ],
            ),
          )
        : controller.isUser.value == true
            ? AccessSettingScreen()
            : DashboardScreen());
  }

  Widget listWidget(
      {required VoidCallback onTap,
      required String name,
      required int totalGrowSpaces,
      required int totalControllers,
      required int totalSensors,
      required int totalAdmins,
      required int totalTechnicians,
      required int growSpaceOnline,
      required int growSpaceOffline,
      required int controllersOnline,
      required int controllersOffline,
      required int sensorOnline,
      required int sensorOffline,
      required VoidCallback onDelete}) {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.organization,
                      height: 18.h,
                      width: 18.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: name,
                      fontSize: 14.sp,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w600,
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 10.w,
                    )),
                    ScrollConfiguration(
                      behavior: AppBehavior(),
                      child: PopupMenuButton<int>(
                        offset: Offset(0, 18.h),
                        padding: EdgeInsets.zero,
                        color:
                            Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                        constraints:
                            BoxConstraints(maxWidth: 240.w, maxHeight: 150.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          AppImages.menu,
                          height: 14.h,
                          width: 8.w,
                          color: Get.isDarkMode
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                        onSelected: (item) {},
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                              padding: EdgeInsets.zero,
                              value: 0,
                              onTap: () {
                                controller.isGrowSpaces.value = true;
                                controller.isUser.value = false;
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.manageGrowspaces,
                                          height: 25.h,
                                          width: 25.w,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText
                                              : AppColors.darkGray,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomText(
                                          text: AppStrings.manageGrowspaces,
                                          fontSize: 15.sp,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText
                                              : AppColors.darkGray,
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
                              )),
                          PopupMenuItem<int>(
                              padding: EdgeInsets.zero,
                              value: 0,
                              onTap: () async {
                                homeController.isOrganization.value = false;
                                controller.isUser.value = true;
                                controller.isGrowSpaces.value = true;
                                await accessSettingController.getUserList();
                                accessSettingController.roleValue.value = "";
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.manageUser,
                                          height: 25.h,
                                          width: 25.w,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText
                                              : AppColors.darkGray,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomText(
                                          text: AppStrings.manageUsers,
                                          fontSize: 15.sp,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText
                                              : AppColors.darkGray,
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
                              )),
                          PopupMenuItem<int>(
                              padding: EdgeInsets.zero,
                              value: 0,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.suspend,
                                          height: 25.h,
                                          width: 25.w,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText
                                              : AppColors.darkGray,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CustomText(
                                          text: AppStrings.suspend,
                                          fontSize: 15.sp,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText
                                              : AppColors.darkGray,
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
                              )),
                          PopupMenuItem<int>(
                              value: 1,
                              padding: EdgeInsets.zero,
                              onTap: () {
                                onDelete();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, right: 10.w, bottom: 9.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.trash,
                                      height: 25.h,
                                      width: 25.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomText(
                                      text: AppStrings.delete,
                                      fontSize: 15.sp,
                                      color: AppColors.red,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onTap();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, bottom: 10.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonWidget(
                                  title: AppStrings.growspaces,
                                  count: "$totalGrowSpaces"),
                              commonWidget(
                                  title: AppStrings.controllers,
                                  count: "$totalControllers"),
                              commonWidget(
                                  title: AppStrings.sensors,
                                  count: "$totalSensors"),
                            ],
                          ),
                          SizedBox(
                            height: 15.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonWidget(
                                  title: AppStrings.admins,
                                  count: "$totalAdmins"),
                              commonWidget(
                                  title: AppStrings.technicians,
                                  count: "$totalTechnicians"),
                              SizedBox(
                                width: 10.w,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          commonDetailWidget(
                              title: AppStrings.growspaces,
                              online: "$growSpaceOnline",
                              offline: "$growSpaceOffline"),
                          SizedBox(
                            height: 10.h,
                          ),
                          commonDetailWidget(
                              title: AppStrings.controllers,
                              online: "$controllersOnline",
                              offline: "$controllersOffline"),
                          SizedBox(
                            height: 10.h,
                          ),
                          commonDetailWidget(
                              title: AppStrings.sensor,
                              online: "$sensorOnline",
                              offline: "$sensorOffline")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
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

  Widget commonWidget({required String title, required String count}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: count,
          color: AppColors.buttonColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }

  Widget commonDetailWidget(
      {required String title,
      required String online,
      required String offline}) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CustomText(
            text: title,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.buttonColor,
          ),
          Expanded(
              child: SizedBox(
            width: 10.w,
          )),
          Image.asset(
            AppImages.greenEllipse,
            height: 8.h,
            width: 8.w,
          ),
          SizedBox(
            width: 5.w,
          ),
          CustomText(
            text: online,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          CustomText(
            text: AppStrings.online,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          SizedBox(
            width: 15.w,
          ),
          Image.asset(
            AppImages.redEllipse,
            height: 8.h,
            width: 8.w,
          ),
          SizedBox(
            width: 5.w,
          ),
          CustomText(
            text: offline,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          CustomText(
            text: AppStrings.offline,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
