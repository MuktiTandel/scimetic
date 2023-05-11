import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class CalendarController extends GetxController {

  RxBool isDay = true.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;
  RxBool isYear = false.obs;

  RxBool isCropWeek = true.obs;
  RxBool isCropMonth = false.obs;
  RxBool isMonth3 = false.obs;
  RxBool isMonth6 = false.obs;
  RxBool isCropYear = false.obs;

  RxBool personalCalendar = false.obs;
  RxBool cropCalendar = true.obs;

  List<String> cropCalendarType = [AppStrings.week,
    AppStrings.month, AppStrings.month3, AppStrings.month6, AppStrings.year];

}