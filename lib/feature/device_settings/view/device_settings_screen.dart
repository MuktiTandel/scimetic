import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_description_textfield.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/device_settings/Model/device_model.dart';
import 'package:scimetic/feature/device_settings/controller/device_settings_controller.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';

class DeviceSettingsScreen extends StatelessWidget {
   DeviceSettingsScreen({Key? key}) : super(key: key);

   final controller = Get.put(DeviceSettingsController());

   final overviewController = Get.put(OverviewController());

   final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: CustomDropDown(
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
                await controller.getDeviceData();
              },
              isEdit: false.obs,
              isEnable: false,
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: AppBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.h,),
                    Column(
                      children: [
                       Obx(() =>  commonListView(
                           title: AppStrings.switches,
                           totalDevice: controller.isGetDevice.value == true
                               ? controller.deviceModel.devices!.devicesSwitch!.total!
                               : 0,
                           totalOnline: controller.isGetDevice.value == true
                               ? controller.deviceModel.devices!.devicesSwitch!.online!
                               : 0,
                           totalOffline: controller.isGetDevice.value == true
                               ? controller.deviceModel.devices!.devicesSwitch!.offline!
                               : 0,
                           isSelect: controller.isSwitches
                       )),
                        SizedBox(height: 8.h,),
                        Obx(() => commonListView(
                            title: AppStrings.sensors,
                            totalDevice: controller.isGetDevice.value == true
                                ? controller.deviceModel.devices!.sensor!.total!
                                : 0,
                            totalOnline: controller.isGetDevice.value == true
                                ? controller.deviceModel.devices!.sensor!.online!
                                : 0,
                            totalOffline: controller.isGetDevice.value == true
                                ? controller.deviceModel.devices!.sensor!.offline!
                                : 0,
                            isSelect: controller.isSensors
                        )),
                        SizedBox(height: 8.h,),
                        Obx(() => commonListView(
                            title: AppStrings.valves,
                            totalDevice: controller.isGetDevice.value == true
                                ? controller.deviceModel.devices!.valve!.total!
                                : 0,
                            totalOnline: controller.isGetDevice.value == true
                                ? controller.deviceModel.devices!.valve!.online!
                                : 0,
                            totalOffline: controller.isGetDevice.value == true
                                ? controller.deviceModel.devices!.valve!.offline!
                                : 0,
                            isSelect: controller.isValves
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commonListView({ required String title,
    required int totalDevice,
    required int totalOffline,
    required int totalOnline,
    required RxBool isSelect,
  }) {
    return Column(
      children: [
        Container(
          color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: title,
                    fontSize: 13.sp,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  Image.asset(
                    AppImages.sync,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: AppStrings.refresh,
                    fontSize: 12.sp,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10.w,),
                  Image.asset(
                    AppImages.settings,
                    height: 15.h,
                    width: 15.w,
                    color: Get.isDarkMode
                        ? Colors.white : AppColors.subTitleColor,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: AppStrings.settings,
                    fontSize: 12.sp,
                    color: Get.isDarkMode
                        ? Colors.white : AppColors.subTitleColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 5.w,),
                  Obx(() => GestureDetector(
                    onTap: (){
                      isSelect.value = !isSelect.value;
                      if ( controller.isSensors.value == true ) {
                        controller.isValves.value = false;
                        controller.isSwitches.value = false;
                      } else if ( controller.isSwitches.value == true ) {
                        controller.isSensors.value = false;
                        controller.isValves.value = false;
                      } else if ( controller.isValves.value == true ) {
                        controller.isSwitches.value = false;
                        controller.isSensors.value = false;
                      }
                    },
                    child: Image.asset(
                      isSelect.value == false
                          ? AppImages.downArrow : AppImages.upArrow,
                      height: 22.h,
                      width: 22.w,
                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                    ),
                  ))
                ],
              ),
              SizedBox(height: 5.h,),
              CustomText(
                text: '${totalDevice.toString()} ${AppStrings.devices}',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Image.asset(
                    AppImages.greenEllipse,
                    height: 8.h,
                    width: 8.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: "$totalOnline",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: AppStrings.online,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  SizedBox(width: 15.w,),
                  Image.asset(
                    AppImages.redEllipse,
                    height: 8.h,
                    width: 8.w,
                  ),
                  SizedBox(width: 5.w,),
                  CustomText(
                    text: "$totalOffline",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: AppStrings.offline,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
              Obx(() => isSelect.value == true
                  ? SizedBox(height: 10.h,)
                  : const SizedBox.shrink()),
              Obx(() =>  isSelect.value == true
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: controller.isSwitches.value == true
                      ? controller.switchDeviceList.length
                      : controller.isSensors.value == true
                      ? controller.sensorDeviceList.length
                      : controller.valvesDeviceList.length,
                  itemBuilder: (BuildContext context, int index) {

                    SensorDevice sensorData = SensorDevice();
                    SensorDevice valvesData = SensorDevice();
                    SwitchDevice switchData = SwitchDevice();

                    int id = 0;
                    String desc = "";
                    String status = "";
                    String location = "";
                    Info1 info1 = Info1();
                    Info2 info2 = Info2();
                    Info3 info3 = Info3();
                    String serialNumber = "";

                    if ( controller.sensorDeviceList.isNotEmpty
                        && controller.isSensors.value == true) {
                      sensorData = controller.sensorDeviceList[index];
                      id = sensorData.id ?? 0;
                      desc = sensorData.description ?? "";
                      status = sensorData.status ?? AppStrings.offline;
                      location = sensorData.location ?? "";
                      info1 = sensorData.data!.info1!;
                      info2 = sensorData.data!.info2!;
                      info3 = sensorData.data!.info3!;
                      serialNumber = sensorData.serialNumber ?? "";
                    }

                    if ( controller.valvesDeviceList.isNotEmpty
                        && controller.isValves.value == true ) {
                      valvesData = controller.valvesDeviceList[index];
                      id = valvesData.id ?? 0;
                      desc = valvesData.description ?? "";
                      status = valvesData.status ?? AppStrings.offline;
                      location = valvesData.location ?? "";
                      info1 = valvesData.data!.info1!;
                      info2 = valvesData.data!.info2!;
                      info3 = valvesData.data!.info3!;
                      serialNumber = valvesData.serialNumber ?? "";
                    }

                    if (controller.switchDeviceList.isNotEmpty
                        && controller.isSwitches.value == true ) {
                      switchData = controller.switchDeviceList[index];
                      id = switchData.id ?? 0;
                      desc = switchData.description ?? "";
                      status = switchData.status ?? AppStrings.offline;
                      location = switchData.location ?? "";
                      info1 = switchData.data!.info1!;
                      info2 = switchData.data!.info2!;
                      info3 = switchData.data!.info3!;
                      serialNumber = switchData.serialNumber ?? "";
                    }

                    return settingWidget(
                      id: id,
                      desc: desc,
                      location: location,
                      status: status.isNotEmpty ? status : AppStrings.offline,
                      isDeviceSelect: controller.isSwitches.value == true
                          ? controller.selectSwitchDevice[index]
                          : controller.isSensors.value == true
                          ? controller.selectSensorDevice[index]
                          : controller.selectValvesDevice[index],
                      onTap: (){
                        if ( controller.isSensors.value == true ) {
                          controller.selectSensorDevice[index].value = !controller.selectSensorDevice[index].value;
                        } else if ( controller.isSwitches.value == true ) {
                          controller.selectSwitchDevice[index].value = !controller.selectSwitchDevice[index].value;
                        } else {
                          controller.selectValvesDevice[index].value = !controller.selectValvesDevice[index].value;
                        }
                      },
                      info1: info1,
                      info2: info2,
                      info3: info3,
                      sensorDeviceData: sensorData,
                      serialNumber: serialNumber,
                      switchDeviceData: switchData,
                      valvesDeviceData: valvesData
                    );
                  }
              )
                  : const SizedBox.shrink())
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  Widget settingWidget({
    required int id,
    required String desc,
    required String location,
    required String status,
    required RxBool isDeviceSelect,
    required VoidCallback onTap,
    required Info1 info1,
    required Info2 info2,
    required Info3 info3,
    required SensorDevice sensorDeviceData,
    required String serialNumber,
    required SwitchDevice switchDeviceData,
    required SensorDevice valvesDeviceData,
  }) {

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.id,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        Text(
                          '$id',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.darkBlue2,
                              fontFamily: "Poppins",
                              letterSpacing: 1.3.w
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Obx(() => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            onTap();
                          },
                          child: Image.asset(
                            isDeviceSelect.value == false
                                ? AppImages.downArrow : AppImages.upArrow,
                            height: 22.h,
                            width: 22.w,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                          ),
                        ))
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.description_,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        CustomText(
                          text: desc,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Get.isDarkMode
                              ? Colors.white : AppColors.subTitleColor,
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.location_,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        Text(
                          location,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Get.isDarkMode
                                  ? Colors.white : AppColors.subTitleColor,
                              fontFamily: "Poppins",
                              letterSpacing: 1.3.w
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        CustomText(
                          text: AppStrings.state,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColors.darkIcon : AppColors.lightBorder,
                        ),
                        Expanded(child: SizedBox(width: 10.w,)),
                        Row(
                          children: [
                            Image.asset(
                              status.contains(AppStrings.online)
                                  ? AppImages.greenEllipse
                                  : AppImages.redEllipse,
                              height: 9.h,
                              width: 9.w,
                            ),
                            SizedBox(width: 5.w,),
                            CustomText(
                              text: status,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: Get.isDarkMode
                                  ? Colors.white : AppColors.subTitleColor,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    CustomText(
                      text: serialNumber,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightIcon,
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1.w,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightBorder,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppImages.sensors,
                      height: 25.h,
                      width: 20.w,
                    ),
                    CustomText(
                      text: AppStrings.reconnect,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: AppColors.buttonColor,
                    ),
                    Image.asset(
                      AppImages.restart,
                      height: 16.h,
                      width: 12.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightGray1,
                    ),
                    CustomText(
                      text: AppStrings.restart,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightGray1,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        controller.isEdit.value = true;
                        controller.serialNumberController.text = serialNumber;
                        controller.descriptionController.text = desc;
                        controller.locationController.text = location;
                        if ( controller.isSwitches.value == true ) {
                          controller.deviceTypeController.text = AppStrings.switches;
                        } else if ( controller.isSensors.value == true ) {
                          controller.deviceTypeController.text = AppStrings.sensor;
                        } else {
                          controller.deviceTypeController.text = AppStrings.valves;
                        }
                        Get.dialog(
                          dialogWidget(
                            sensorDeviceData: sensorDeviceData,
                            valvesDeviceData: valvesDeviceData,
                            switchDeviceData: switchDeviceData,
                            id: id
                          )
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.edit,
                            height: 25.h,
                            width: 22.w,
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightGray1,
                          ),
                          SizedBox(width: 5.w,),
                          CustomText(
                            text: AppStrings.edit,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightGray1,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      AppImages.trash,
                      height: 25.h,
                      width: 25.w,
                    ),
                    CustomText(
                      text: AppStrings.delete,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: AppColors.red,
                    ),
                  ],
                ),
              ),
              Obx(() => isDeviceSelect.value == true
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    child: controller.isSwitches.value == true
                      ? switchesTable(info1: info1, info2: info2, info3: info3)
                      : sensorTable(sensorDeviceData: sensorDeviceData),
                  )
                  : const SizedBox.shrink()
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }

  Widget switchesTable ({
    required Info1 info1,
    required Info2 info2,
    required Info3 info3
  }) {
    return Table(
      border: TableBorder.all(
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder
      ),
      children: [
        TableRow(
            children: [
              Container(
                height: 24.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                child: CustomText(
                  text: AppStrings.keys,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                ),
              ),
              Container(
                height: 24.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                child: CustomText(
                  text: AppStrings.value,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                ),
              ),
            ]
        ),
        commonTableView(title: AppStrings.module, value: info1.module ?? ""),
        commonTableView(title: AppStrings.version, value: info1.version ?? ""),
        commonTableView(title: AppStrings.groupTopic, value: info1.groupTopic ?? ""),
        commonTableView(title: AppStrings.fallbackTopic, value: info1.fallbackTopic ?? ""),
        commonTableView(title: AppStrings.hostname, value: info2.hostname ?? ""),
        commonTableView(title: AppStrings.iPAddress, value: info2.ipAddress ?? ""),
        commonTableView(title: AppStrings.webServerMode, value: info2.webServerMode ?? ""),
        commonTableView(title: AppStrings.restartReason, value: info3.restartReason ?? ""),
      ],
    );
  }

  Widget sensorTable ({
    required SensorDevice sensorDeviceData
  }) {
    return Table(
      border: TableBorder.all(
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder
      ),
      children: [
        TableRow(
            children: [
              Container(
                height: 24.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                child: CustomText(
                  text: AppStrings.keys,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                ),
              ),
              Container(
                height: 24.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                child: CustomText(
                  text: AppStrings.value,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                ),
              ),
            ]
        ),
        commonTableView(title: AppStrings.heap, value: "${sensorDeviceData.data!.heap}"),
        commonTableView(title: AppStrings.time, value: "${sensorDeviceData.data!.time}"),
        commonTableView(title: AppStrings.ap, value: "${sensorDeviceData.data!.wifi!.ap}"),
        commonTableView(title: AppStrings.mode, value: sensorDeviceData.data!.wifi!.mode ?? ""),
        commonTableView(title: AppStrings.rSSI, value: "${sensorDeviceData.data!.wifi!.rssi}"),
        commonTableView(title: AppStrings.sSId, value: sensorDeviceData.data!.wifi!.ssId ?? ""),
        commonTableView(title: AppStrings.bSSId, value: sensorDeviceData.data!.wifi!.bssId ?? ""),
        commonTableView(title: AppStrings.signal, value: "${sensorDeviceData.data!.wifi!.signal}"),
        commonTableView(title: AppStrings.channel, value: "${sensorDeviceData.data!.wifi!.channel}"),
        commonTableView(title: AppStrings.downtime, value: sensorDeviceData.data!.wifi!.downtime ?? ""),
      ],
    );
  }

  TableRow commonTableView({required String title, required String value}) {
    return TableRow(
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.transparent : Colors.white
        ),
        children: [
          Container(
            height: 25.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            child: CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
            ),
          ),
          Container(
            height: 25.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            child: Text(
                value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                fontFamily: "Poppins"
              ),
            )
          ),
        ]
    );
  }

  Widget dialogWidget({
  required SensorDevice sensorDeviceData,
   required SensorDevice valvesDeviceData,
   required SwitchDevice switchDeviceData,
    required int id
  }) {
    return CommonDialogWidget(
        title: AppStrings.addNewDevice,
        onTap: (){
          Get.back();
          controller.serialNumberController.clear();
          controller.deviceTypeController.clear();
          controller.locationController.clear();
          controller.descriptionController.clear();
        },
        widget: SizedBox(
          width: 350.w,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.serialNumber,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode
                      ? AppColors.darkText : AppColors.lightText,
                ),
                SizedBox(height: 6.h,),
                SizedBox(
                  height: 38.h,
                  child: CustomTextField(
                    controller: controller.serialNumberController,
                    isFilled: false,
                    readOnly: controller.isEdit.value == true ? true : false,
                    hintText: AppStrings.serialNumber,
                    borderRadius: 8,
                    focusBorderColor: AppColors.buttonColor,
                    textInputType: TextInputType.number,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    onchange: (value){},
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomText(
                  text: AppStrings.deviceType,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode
                      ? AppColors.darkText : AppColors.lightText,
                ),
                SizedBox(height: 6.h,),
                SizedBox(
                  height: 38.h,
                  child: CustomTextField(
                    controller: controller.deviceTypeController,
                    isFilled: false,
                    readOnly: controller.isEdit.value == true ? true : false,
                    hintText: AppStrings.deviceType,
                    borderRadius: 8,
                    focusBorderColor: AppColors.buttonColor,
                    textInputType: TextInputType.number,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    onchange: (value){},
                  ),
                ),
                SizedBox(height: 10.h,),
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
                    hintText: AppStrings.location,
                    borderRadius: 8,
                    focusBorderColor: AppColors.buttonColor,
                    textInputType: TextInputType.number,
                    contentPadding: EdgeInsets.only(left: 10.w),
                    onchange: (value){},
                  ),
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
                CustomButton(
                  height: 40.h,
                  onTap: () async {
                    if ( controller.isEdit.value == true ) {
                      if ( controller.isSensors.value == true ) {
                        sensorDeviceData.location = controller.locationController.text;
                        sensorDeviceData.description = controller.descriptionController.text;
                      } else if ( controller.isValves.value == true ) {
                        valvesDeviceData.location = controller.locationController.text;
                        valvesDeviceData.description = controller.descriptionController.text;
                      } else {
                        switchDeviceData.location = controller.locationController.text;
                        switchDeviceData.description = controller.descriptionController.text;
                      }
                      await controller.updateDevice(
                          sensorDevice: controller.isSensors.value == true
                              ? sensorDeviceData : valvesDeviceData,
                          id: id,
                          switchDevice: switchDeviceData,
                      ).whenComplete(() async {
                        await controller.getDeviceData();
                      });
                    }
                  },
                  buttonText: AppStrings.save,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h,)
              ],
            ),
          ),
        )
    );
  }

}
