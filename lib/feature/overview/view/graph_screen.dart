import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_appbar.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/overview/controller/graph_controller.dart';
import 'package:scimetic/feature/overview/element/device_overview_widget.dart';
import 'package:scimetic/feature/overview/element/growsheet_widget.dart';
import 'package:scimetic/feature/overview/element/grpah_widget.dart';

class GraphScreen extends StatelessWidget {
   GraphScreen({Key? key}) : super(key: key);

   final controller = Get.put(GraphController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 45.h),
        child: CommonAppbar(
          drawerTap: (){
            Get.back();
          },
          title: AppStrings.overview,
          notificationTap: (){
            Get.toNamed(AppPages.NOTIFICATION);
          },
          profileTap: (){},
          leadingIcon: AppImages.backArrow,
          isPersonal: false.obs,
          isCrop: false.obs,
        ),
      ),
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              Obx(() => graphWidget(
                  title: controller.title(),
                  image: controller.image(),
                  value: controller.value(),
                  color: controller.color(),
                  value1: controller.value_(),
                  isHour: controller.isHour.value,
                  hourSelect: (){
                    if ( controller.isHour.value == false ) {
                      controller.isHour.value = true;
                      controller.isWeek.value = false;
                      controller.isMonth.value = false;
                    }
                  },
                  isWeek: controller.isWeek.value,
                  weekSelect: (){
                    if ( controller.isWeek.value == false ) {
                      controller.isHour.value = false;
                      controller.isWeek.value = true;
                      controller.isMonth.value = false;
                    }
                  },
                  isMonth: controller.isMonth.value,
                  monthSelect: (){
                    if ( controller.isMonth.value == false ) {
                      controller.isHour.value = false;
                      controller.isWeek.value = false;
                      controller.isMonth.value = true;
                    }
                  },
                  graph: controller.graph()
              ),),
              SizedBox(height: 10.h,),
              growSheetWidget(),
              SizedBox(height: 10.h,),
              deviceOverviewWidget(),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}
