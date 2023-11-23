import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_description_textfield.dart';
import 'package:scimetic/core/elements/common_dialog_widget.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';
import 'package:scimetic/core/elements/select_widget.dart';
import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';
import 'package:scimetic/feature/to_do/controller/todo_controller.dart';
import 'package:scimetic/feature/to_do/model/company_user_model.dart';
import 'package:scimetic/feature/to_do/model/todo_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final controller = Get.put(TodoController());

  final homeController = Get.put(HomeController());

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     onWillPop: homeController.onWillPop,
      child: Scaffold(
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
                      Obx(() => controller.isGetData.value == false ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      ) : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.isTodo.value == true
                              ? controller.todoList.length
                              : controller.isProgress.value == true
                              ? controller.inProgressList.length
                              : controller.completedList.length,
                          itemBuilder: (BuildContext context, int index ) {
    
                            Todo todo = Todo();
    
                            String growSpaceId = AppStrings.assignGrowSpace;
    
                            String date = "";
    
                            String startDate = "";
    
                            if ( controller.isTodo.value == true ) {
    
                              todo = controller.todoList[index];
    
                              if ( controller.todoIdentifierList.length > index ) {
                                growSpaceId =
                                controller.todoIdentifierList[index];
                              }
    
                              DateTime parseDate = DateFormat("dd.MM.yyyy").parse(controller.todoList[index].dueDate!);
                              date = DateFormat("dd.MM.yyyy").format(parseDate);
    
                            } else if ( controller.isProgress.value == true ) {
    
                              todo = controller.inProgressList[index];
    
                              if ( controller.inProgressIdentifierList.length > index ) {
                                growSpaceId =
                                controller.inProgressIdentifierList[index];
                              }
    
                              DateTime parseDate = DateFormat("dd.MM.yyyy").parse(controller.inProgressList[index].dueDate!);
                              date = DateFormat("dd.MM.yyyy").format(parseDate);
    
                            } else if ( controller.isCompleted.value == true ) {
    
                              todo = controller.completedList[index];
    
                              if ( controller.completedIdentifierList.length > index ) {
                                growSpaceId =
                                controller.completedIdentifierList[index];
                              }
    
                              DateTime start = DateFormat("dd.MM.yyyy").parse(controller.completedList[index].dueDate!);
                              startDate = DateFormat("dd.MM.yyyy").format(start);
    
                            }
    
                            return listWidget(
                                isCompleted: controller.isCompleted.value,
                              desc: todo.description ?? "",
                              date: date,
                              tag: todo.tag ?? "",
                              growSpace: growSpaceId,
                              startDate: startDate,
                              endDate: todo.completedAt ?? "",
                              isInProgress: controller.isProgress.value,
                              onDelete: () async {
                                  controller.deleteTodo(id: todo.id!).whenComplete(() async{
                                    await controller.getTodoList();
                                  });
                              },
                              onTodoEdit: (){
    
                                  controller.isEdit.value = true;
    
                                  controller.editTodo = todo;
    
                                  String date = "";
    
                                  DateTime parseDate = DateFormat("dd.MM.yyyy").parse(todo.dueDate!);
                                  date = DateFormat("dd.MM.yyyy").format(parseDate);
    
                                controller.dateTimeController.text = date;
                                controller.descriptionController.text = todo.description ?? "";
                                controller.tagController.text = todo.tag ?? "";
                                controller.growSpaceId.value = todo.growspaceId ?? 0;
                                controller.assignedTo.value = todo.assignedTo ?? 0;
    
                                for (var element in controller.userNameList) {
                                  if ( element.id == controller.assignedTo.value) {
                                    controller.selectValue = element;
                                  }
                                }
    
                                for (var element in controller.growSpaceList) {
                                  if ( element.id == controller.growSpaceId.value ) {
                                    controller.selectGrowSpace = element;
                                  }
                                }
    
                                Future.delayed(const Duration(seconds: 0), (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return commonDialog(context: context);
                                      }
                                  );
                                });
                              },
                              onInProgressEdit: (){
    
                                controller.isEdit.value = true;
    
                                controller.editTodo = todo;
    
                                String date = "";
    
                                DateTime parseDate = DateFormat("dd.MM.yyyy").parse(todo.dueDate!);
                                date = DateFormat("dd.MM.yyyy").format(parseDate);
    
                                controller.dateTimeController.text = date;
                                controller.descriptionController.text = todo.description ?? "";
                                controller.growSpaceId.value = todo.growspaceId ?? 0;
                                controller.assignedTo.value = todo.assignedTo ?? 0;
    
                                for (var element in controller.userNameList) {
                                  if ( element.id == controller.assignedTo.value) {
                                    controller.selectValue = element;
                                  }
                                }
    
                                for (var element in controller.growSpaceList) {
                                  if ( element.id == controller.growSpaceId.value ) {
                                    controller.selectGrowSpace = element;
                                  }
                                }
    
                                Future.delayed(const Duration(seconds: 0), (){
                                  Get.dialog(
                                      commonDialog(context: context)
                                  );
                                });
                              },
                              data: todo
                            );
                          }
                      )),
                      SizedBox(height: 10.h,),
                      Obx(() =>  controller.isCompleted.value == false ? CustomButton(
                       onTap: (){
                         controller.isEdit.value = false;
                         controller.descriptionController.clear();
                         controller.tagController.clear();
                         controller.dateTimeController.clear();
                         Get.dialog(
                           commonDialog(context: context)
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
      ),
    );
  }

  Widget listWidget({
    required bool isCompleted,
    required String desc,
    required String date,
    required String tag,
    required String growSpace,
    required String startDate,
    required String endDate,
    required bool isInProgress,
    required VoidCallback onDelete,
    required VoidCallback onTodoEdit,
    required VoidCallback onInProgressEdit,
    required Todo data
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: desc,
                      color: Get.isDarkMode ? Colors.white : AppColors.lightText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  controller.isCompleted.value == false
                      ? controller.isProgress.value == false
                      ? PopupMenuButton<int>(
                        offset: Offset(0, 17.h),
                        padding: EdgeInsets.zero,
                        color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                        constraints: BoxConstraints(
                            maxWidth: 220.w,
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
                          onTap: () async {

                            data.stage = "inProgress";

                            await controller.updateTodo(todo: data).whenComplete(() async {
                              await controller.getTodoList();
                            });

                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.forward,
                                      height: 25.h,
                                      width: 25.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                      text: AppStrings.moveForward,
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
                          onTap: () async{
                            data.stage = "completed";

                            await controller.updateTodo(todo: data).whenComplete(() async {
                              await controller.getTodoList();
                            });
                          },
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
                          onTap: (){
                            onTodoEdit();
                          },
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
                          onTap: (){
                            onDelete();
                          },
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
                  )
                      : PopupMenuButton<int>(
                       offset: Offset(0, 17.h),
                       padding: EdgeInsets.zero,
                       color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                       constraints: BoxConstraints(
                           maxWidth: 205.w,
                           maxHeight: 150.h
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
                          onTap: () async {
                            data.stage = "toDo";

                            await controller.updateTodo(todo: data).whenComplete(() async {
                              await controller.getTodoList();
                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.backward,
                                      height: 25.h,
                                      width: 25.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                      text: AppStrings.moveBackward,
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
                          onTap: () async {
                            data.stage = "completed";

                            await controller.updateTodo(todo: data).whenComplete(() async {
                              await controller.getTodoList();
                            });
                          },
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
                          onTap: (){
                            onInProgressEdit();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          onTap: (){
                            onDelete();
                          },
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
                  )
                      : PopupMenuButton<int>(
                        offset: Offset(0, 17.h),
                        padding: EdgeInsets.zero,
                        color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                        constraints: BoxConstraints(
                            maxWidth: 205.w,
                            maxHeight: 80.h
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
                          onTap: () async {
                            data.stage = "toDo";

                            await controller.updateTodo(todo: data).whenComplete(() async {
                              await controller.getTodoList();
                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.backward,
                                      height: 25.h,
                                      width: 25.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                    ),
                                    SizedBox(width: 10.w,),
                                    CustomText(
                                      text: AppStrings.moveToTodo,
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
                              onTap: () async {

                                data.stage = "inProgress";

                                await controller.updateTodo(todo: data).whenComplete(() async {
                                  await controller.getTodoList();
                                });

                              },
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.backward,
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
                          )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h,),
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
                       text: 'due $date',
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
                        text: startDate,
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
                        text: endDate,
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
              isInProgress == false ? Row(
                children: [
                  Image.asset(
                    AppImages.label,
                    height: 20.h,
                    width: 20.w,
                    color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                  ),
                  SizedBox(width: 10.w,),
                  CustomText(
                    text: tag,
                    color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ],
              ) : const SizedBox.shrink(),
              SizedBox(height: 10.h,),
              CustomText(
                  text: AppStrings.growspaces,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1,
              ),
              SizedBox(height: 5.h,),
              CustomText(
                text: growSpace,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : AppColors.lightGray,
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

  Widget commonDialog({required BuildContext context}) {
    return CommonDialogWidget(
            title: AppStrings.addNewTask,
            onTap: (){
              Get.back();
            },
            widget: SizedBox(
              width: 310.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.isValid.value == true
                        ? const SizedBox.shrink()
                        : commonErrorWidget(
                        onTap: (){
                          controller.isValid.value = true;
                        },
                        errorMessage: controller.errorMessage.value
                    )
                    ),
                    Obx(() => controller.isValid.value == false
                        ? SizedBox(height: 10.h,)
                        : const SizedBox.shrink()
                    ),
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
                        readOnly: true,
                        isFilled: false,
                        borderRadius: 8,
                        focusBorderColor: AppColors.buttonColor,
                        hintText: AppStrings.selectDate,
                        contentPadding: EdgeInsets.only(left: 10.w),
                        suffixWidget: GestureDetector(
                          onTap: (){
                            FocusScope.of(context).unfocus();
                            showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                    backgroundColor: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(
                                              text: AppStrings.setDueDate,
                                              fontSize: 14.sp,
                                              color: Get.isDarkMode
                                                  ? Colors.white : AppColors.subTitleColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            Expanded(child: SizedBox(width: 10.w,)),
                                            GestureDetector(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: Image.asset(
                                                AppImages.close,
                                                height: 25.h,
                                                width: 25.w,
                                                color: Get.isDarkMode
                                                    ? AppColors.darkText : AppColors.lightIcon,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.h,),
                                        SizedBox(
                                          width: 200.w,
                                          height: 220.h,
                                          child: SfDateRangePicker(
                                            showActionButtons: true,
                                            controller: controller.date,
                                            view: DateRangePickerView.month,
                                            headerStyle: DateRangePickerHeaderStyle(
                                              textStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14.sp,
                                                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            onSubmit: (context){
                                              Get.back();
                                              AppConst().debug('Select date => ${controller.date.selectedDate}');
                                              controller.dateTimeController.text = "${controller.date.selectedDate!.day}"
                                                  ".${controller.date.selectedDate!.month}.${controller.date.selectedDate!.year}";
                                            },
                                            onCancel: (){
                                              Get.back();
                                            },
                                            showNavigationArrow: true,
                                            monthViewSettings: DateRangePickerMonthViewSettings(
                                              showTrailingAndLeadingDates: true,
                                              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                                  textStyle: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12.sp,
                                                      color: Get.isDarkMode ? AppColors.darkBlue3 : AppColors.lightIcon,
                                                      fontWeight: FontWeight.w500
                                                  )
                                              ),
                                            ),
                                            monthCellStyle: DateRangePickerMonthCellStyle(
                                              textStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12.sp,
                                                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                                                  fontWeight: FontWeight.w500
                                              ),
                                              disabledDatesTextStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12.sp,
                                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                                  fontWeight: FontWeight.w500
                                              ),
                                              todayTextStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12.sp,
                                                  color: Get.isDarkMode ? Colors.white : AppColors.lightText,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            selectionColor: AppColors.buttonColor,
                                            todayHighlightColor: AppColors.lightIcon,
                                            selectionTextStyle: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 12.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                          child: Padding(
                            padding:  EdgeInsets.all(13.w),
                            child: Image.asset(
                              AppImages.calender,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            ),
                          ),
                        ),
                        onchange: (value) {},
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Obx(() => controller.isProgress.value == false
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            focusBorderColor: AppColors.buttonColor,
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
                      ],
                    )
                        : const SizedBox.shrink()
                    ),
                    CustomText(
                      text: AppStrings.assignedTo,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightText,
                    ),
                    SizedBox(height: 6.h,),
                    Obx(() => DropdownButtonFormField2<User>(
                      value: controller.isEdit.value == true ? controller.selectValue : null,
                      itemHeight: 40.h,
                      dropdownMaxHeight: 150.h,
                      dropdownWidth: 290.w,
                      buttonPadding: EdgeInsets.only(left: 10.w),
                      isExpanded: true,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(right: 10.w, top: 12.w, bottom: 12.w,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightBorder,)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightBorder,)
                        ),
                        filled: Get.isDarkMode ? true : false,
                        fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
                      ),
                      hint: CustomText(
                        text: AppStrings.assignToUser,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                      ),
                      icon: Image.asset(
                        AppImages.down,
                        height: 20.h,
                        width: 20.w,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                      ),
                      offset: const Offset(0, -20),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white
                      ),
                      items: controller.userNameList.map((e) {
                        return DropdownMenuItem(
                            value: e,
                            child: CustomText(
                              text: e.name!,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            )
                        );
                      }).toList(),
                      onChanged: ( User? value) {
                        controller.selectValue = value!;
                        controller.assignedTo.value = value.id!;
                        AppConst().debug('select value => ${value.id} ${value.name}');
                      },
                    ),),
                    SizedBox(height: 10.h,),
                    CustomText(
                      text: AppStrings.growspaces,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightText,
                    ),
                    SizedBox(height: 6.h,),
                    Obx(() => DropdownButtonFormField2<GrowController>(
                      value: controller.isEdit.value == true ? controller.selectGrowSpace : null,
                      itemHeight: 40.h,
                      dropdownMaxHeight: 150.h,
                      dropdownWidth: 290.w,
                      buttonPadding: EdgeInsets.only(left: 10.w),
                      isExpanded: true,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(right: 10.w, top: 12.w, bottom: 12.w,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightBorder,)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightBorder,)
                        ),
                        filled: Get.isDarkMode ? true : false,
                        fillColor: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
                      ),
                      hint: CustomText(
                        text: AppStrings.assignGrowSpace,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                      ),
                      icon: Image.asset(
                        AppImages.down,
                        height: 20.h,
                        width: 20.w,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                      ),
                      offset:  Offset(0, 30.h),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white
                      ),
                      items: controller.growSpaceList.map((e) {
                        return DropdownMenuItem(
                            value: e,
                            child: CustomText(
                              text: e.identifier!,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            )
                        );
                      }).toList(),
                      onChanged: ( GrowController? value) {
                        controller.selectGrowSpace = value!;
                        controller.growSpaceId.value = value.id!;
                        AppConst().debug('select value => ${value.id} ${value.name}');
                      },
                    ),),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        Expanded(
                          child: OutLineButton(
                            onTap: (){
                              controller.descriptionController.clear();
                              controller.dateTimeController.clear();
                              controller.tagController.clear();
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
                    SizedBox(height: 10.h,)
                  ],
                ),
              ),
            )
        );
  }
}
