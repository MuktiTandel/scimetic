import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';

class CropWeek extends StatefulWidget {
   const CropWeek({
     Key? key,
     required this.getDay,
     required this.getDates
   }) : super(key: key);

   final int getDay;
   final List<int> getDates;

  @override
  State<CropWeek> createState() => _CropWeekState();
}

class _CropWeekState extends State<CropWeek> {

  DateTime selectedDate = DateTime.now();

  int currentDateSelectedIndex = 0;

  ScrollController scrollController = ScrollController();

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  List<int> datesList = [];

  int lastDay = 0;

  @override
  void initState() {
    super.initState();
    datesList.addAll(widget.getDates);
    lastDay = datesList.last;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: CustomText(
                text: DateFormat('MMMM, yyyy').format(DateTime.now()),
              color: AppColors.buttonColor,
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
            ),
          ),
          SizedBox(
            height: 515.h,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                lastDay = datesList.last;
                datesList.clear();
                for( int i = lastDay + 1; i < lastDay + 8; i++ ) {
                  datesList.add(i);
                }
                setState(() {

                });
              },
              itemCount: 10,
                itemBuilder: (context,int index) {
                  return commonView();
                }
            ),
          )
        ],
      ),
    );
  }

  Widget commonView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: SizedBox(
            height: 50.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index ) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: listOfDays[index],
                          color: AppColors.lightIcon,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 5.h,),
                        CustomText(
                          text: datesList[index].toString(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleColor,
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index ) {
                  return SizedBox(width: 25.w,);
                },
                itemCount: 7
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: 470.h,
              width: Get.width,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: SizedBox(width: 10.w,)),
                  VerticalDivider(
                    thickness: 1.w,
                    color: AppColors.lightGray3,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  VerticalDivider(
                    thickness: 1.w,
                    color: AppColors.lightGray3,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  VerticalDivider(
                    thickness: 1.w,
                    color: AppColors.lightGray3,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  VerticalDivider(
                    thickness: 1.w,
                    color: AppColors.lightGray3,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  VerticalDivider(
                    thickness: 1.w,
                    color: AppColors.lightGray3,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  VerticalDivider(
                    thickness: 1.w,
                    color: AppColors.lightGray3,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
