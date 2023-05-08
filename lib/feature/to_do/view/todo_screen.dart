import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/feature/to_do/controller/todo_controller.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({Key? key}) : super(key: key);

  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isTodo.value == false ) {
                          controller.isTodo.value = true;
                          controller.isProgress.value = false;
                          controller.isCompleted.value = false;
                        }
                      },
                      text: AppStrings.toDo,
                      isSelected: controller.isTodo.value
                  ),)
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isProgress.value == false ) {
                          controller.isTodo.value = false;
                          controller.isProgress.value = true;
                          controller.isCompleted.value = false;
                        }
                      },
                      text: AppStrings.inProgress,
                      isSelected: controller.isProgress.value
                  ),)
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isCompleted.value == false ) {
                          controller.isTodo.value = false;
                          controller.isProgress.value = false;
                          controller.isCompleted.value = true;
                        }
                      },
                      text: AppStrings.completed,
                      isSelected: controller.isCompleted.value
                  )),
                )
              ],
            ),
            SizedBox(height: 10.h,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.isTodo.value == true
                            ? 3 : controller.isProgress.value == true ? 1 : 1,
                        itemBuilder: (BuildContext context, int index ) {
                          return listWidget(isCompleted: controller.isCompleted.value);
                        }
                    )),
                    SizedBox(height: 10.h,),
                    Obx(() =>  controller.isCompleted.value == false ? CustomButton(
                     onTap: (){
                       Get.dialog(
                         CommonDialogWidget(
                             title: AppStrings.addNewTask,
                             widget: SizedBox(
                               width: 310.w,
                               child: Padding(
                                   padding: EdgeInsets.symmetric(horizontal: 10.w),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     CustomText(
                                       text: AppStrings.taskName,
                                       fontWeight: FontWeight.w500,
                                       color: Get.isDarkMode
                                           ? AppColors.darkText : AppColors.lightText,
                                     ),
                                     SizedBox(height: 6.h,),
                                     SizedBox(
                                       height: 38.h,
                                       width: 310.w,
                                       child: CustomTextField(
                                         controller: controller.taskNameController,
                                         isFilled: false,
                                         hintText: AppStrings.taskName,
                                         borderRadius: 8,
                                         focusBorderColor: AppColors.buttonColor,
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
                                     Container(
                                       height: 100.h,
                                       padding: EdgeInsets.only(left: 10.w, right: 10.w,bottom: 10.h),
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(8),
                                           border: Border.all(
                                             color: Get.isDarkMode
                                                 ? AppColors.darkText : AppColors.lightBorder,
                                           )
                                       ),
                                       child: TextFormField(
                                         controller: controller.descriptionController,
                                         maxLength: 80,
                                         maxLines: 10,
                                         cursorColor: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                         style:  TextStyle(
                                           fontFamily: "Poppins",
                                           fontSize: 15.sp,
                                           color: Get.isDarkMode ? Colors.white : Colors.black,
                                         ),
                                         buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }){
                                           return Obx(() => CustomText(
                                             text: "${controller.descriptionLength}/80",
                                             fontSize: 13.sp,
                                             color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                           ));
                                         },
                                         decoration: InputDecoration(
                                             hintText: AppStrings.placeholder,
                                             border: InputBorder.none,
                                             hintStyle: TextStyle(
                                                 color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                                 fontSize: 14.sp,
                                                 fontFamily: "Poppins"
                                             )
                                         ),
                                         onChanged: (value) {
                                           controller.descriptionLength.value = value.length;
                                         },
                                       ),
                                     ),
                                     SizedBox(height: 10.h,),
                                     CustomText(
                                       text: AppStrings.dueDate,
                                       fontWeight: FontWeight.w500,
                                       fontSize: 14.sp,
                                       color: Get.isDarkMode
                                           ? AppColors.darkText : AppColors.lightText,
                                     ),
                                     SizedBox(height: 6.h,),
                                     SizedBox(
                                       height: 40.h,
                                       child: CustomTextField(
                                         controller: controller.dateTimeController,
                                         isFilled: false,
                                         borderRadius: 8,
                                         hintText: AppStrings.selectDate,
                                         contentPadding: EdgeInsets.only(left: 10.w),
                                         suffixWidget: Padding(
                                           padding:  EdgeInsets.all(13.w),
                                           child: Image.asset(
                                             AppImages.calender,
                                             color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                           ),
                                         ),
                                         onchange: (value) {},
                                       ),
                                     ),
                                     SizedBox(height: 10.h,),
                                     CustomText(
                                       text: AppStrings.addTag,
                                       fontWeight: FontWeight.w500,
                                       fontSize: 14.sp,
                                       color: Get.isDarkMode
                                           ? AppColors.darkText : AppColors.lightText,
                                     ),
                                     SizedBox(height: 6.h,),
                                     SizedBox(
                                       height: 40.h,
                                       child: CustomTextField(
                                         controller: controller.tagController,
                                         isFilled: false,
                                         borderRadius: 8,
                                         hintText: AppStrings.tagName,
                                         contentPadding: EdgeInsets.only(left: 10.w),
                                         suffixWidget: Padding(
                                           padding:  EdgeInsets.all(13.w),
                                           child: Image.asset(
                                             AppImages.label,
                                             color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                           ),
                                         ),
                                         onchange: (value) {},
                                       ),
                                     ),
                                     SizedBox(height: 10.h,),
                                     CustomText(
                                       text: AppStrings.assignedTo,
                                       fontWeight: FontWeight.w500,
                                       fontSize: 14.sp,
                                       color: Get.isDarkMode
                                           ? AppColors.darkText : AppColors.lightText,
                                     ),
                                     SizedBox(height: 6.h,),
                                     CustomDropDown(
                                       hintText: AppStrings.selectAssignName,
                                       itemList: controller.userNameList,
                                       value: controller.userNameList.first,
                                       onChange: (value) {
                                         controller.selectValue.value = value;
                                       },
                                     ),
                                     SizedBox(height: 10.h,),
                                     Row(
                                       children: [
                                         Expanded(
                                           child: OutLineButton(
                                             onTap: (){
                                               Get.back();
                                             },
                                             color: AppColors.red,
                                             buttonText: AppStrings.cancel,
                                           ),
                                         ),
                                         SizedBox(width: 10.w,),
                                         Expanded(
                                           child: CustomButton(
                                             onTap: (){
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
                                     SizedBox(height: 10.h,)
                                   ],
                                 ),
                               ),
                             )
                         )
                       );
                     },
                     buttonText: AppStrings.addTask,
                     child: Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           SvgPicture.asset(
                             AppImages.add,
                             height: 15.h,
                             width: 15.w,
                           ),
                           SizedBox(width: 10.w,),
                           CustomText(
                             text: AppStrings.addTask,
                             fontSize: 13.sp,
                             fontWeight: FontWeight.w500,
                           )
                         ],
                       ),
                     ),
                   ) : const SizedBox.shrink(),),
                    SizedBox(height: 20.h,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectWidget({ required VoidCallback onTap, required String text, required bool isSelected}) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 35.h,
        decoration: BoxDecoration(
            color: isSelected == true
                ? Get.isDarkMode ? AppColors.darkBlue : Colors.white
                : Get.isDarkMode ? AppColors.darkTheme : AppColors.lightGray2,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: isSelected == true
                ? Get.isDarkMode ? Colors.white : Colors.black
                : Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget listWidget({required bool isCompleted}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CustomText(
                    text: AppStrings.taskName,
                    color: AppColors.buttonColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  PopupMenuButton<int>(
                    offset: Offset(0, 17.h),
                    padding: EdgeInsets.zero,
                    color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                    constraints: BoxConstraints(
                        maxWidth: 205.w,
                        maxHeight: 148.h
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset(
                      AppImages.menu,
                      height: 14.h,
                      width: 8.w,
                      color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                    ),
                    onSelected: (item) {},
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                          padding: EdgeInsets.zero,
                          value: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.progressClock,
                                      height: 25.h,
                                      width: 25.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                      text: AppStrings.moveToInProgress,
                                      fontSize: 15.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
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
                          )
                      ),
                      PopupMenuItem<int>(
                          padding: EdgeInsets.zero,
                          value: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                        AppImages.progressCheck,
                                        height: 25.h,
                                        width: 25.w,
                                        color: AppColors.buttonColor
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                      text: AppStrings.moveToCompleted,
                                      fontSize: 15.sp,
                                      color: AppColors.buttonColor,
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
                          )
                      ),
                      PopupMenuItem<int>(
                          padding: EdgeInsets.zero,
                          value: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.edit,
                                      height: 25.h,
                                      width: 25.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                      text: AppStrings.edit,
                                      fontSize: 15.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
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
                          )
                      ),
                      PopupMenuItem<int>(
                          value: 1,
                          padding: EdgeInsets.zero,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.trash,
                                  height: 25.h,
                                  width: 25.w,
                                ),
                                SizedBox(width: 10.w,),
                                CustomText(
                                  text: AppStrings.delete,
                                  fontSize: 15.sp,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h,),
              CustomText(
                text: AppStrings.taskDesc,
                color: Get.isDarkMode ? Colors.white : AppColors.lightText,
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  isCompleted == false ? Row(
                   children: [
                     Image.asset(
                       AppImages.calender,
                       height: 15.h,
                       width: 15.w,
                       color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                     ),
                     SizedBox(width: 10.w,),
                     CustomText(
                       text: 'due 20.04.2023',
                       color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                       fontWeight: FontWeight.w500,
                       fontSize: 13.sp,
                     ),
                   ],
                 ) : Row(
                    children: [
                      Image.asset(
                        AppImages.checkCalender,
                        height: 15.h,
                        width: 15.w,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 10.w,),
                      CustomText(
                        text: '20.04.2023',
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      SizedBox(width: 20.w,),
                      Image.asset(
                        AppImages.roundedDone,
                        height: 15.h,
                        width: 15.w,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 10.w,),
                      CustomText(
                        text: '20.04.2023',
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(width: 10.w,)),
                  CircleAvatar(
                    maxRadius: 9.h,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(AppImages.group14),
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Image.asset(
                    AppImages.label,
                    height: 20.h,
                    width: 20.w,
                    color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                  ),
                  SizedBox(width: 10.w,),
                  CustomText(
                    text: 'Growspace works',
                    color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              isCompleted == false ? Row(
                children: [
                  Image.asset(
                    AppImages.message,
                    height: 18.h,
                    width: 18.w,
                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1,
                  ),
                  SizedBox(width: 10.w,),
                  CustomText(
                    text: AppStrings.discuss,
                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ],
              ) : Row(
                children: [
                  Image.asset(
                      AppImages.archive,
                    height: 20.h,
                    width: 20.w,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  SizedBox(width: 10.w,),
                  CustomText(
                      text: AppStrings.archive,
                    fontSize: 13.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
