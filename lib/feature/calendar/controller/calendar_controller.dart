import 'package:get/get.dart';
import 'package:scimetic/core/const/app_const.dart';
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

  getIndex() {

    DateTime selectedDate = DateTime.now();

    AppConst().debug('today day => ${selectedDate.weekday}');

    return selectedDate.weekday;
  }

  getDateList() {

    List<int> getDates = [];

    DateTime selectedDate = DateTime.now();

    int weekDay = selectedDate.weekday;

    if (weekDay == 5 ) {
      getDates.add(DateTime.now().add(Duration(days: weekDay - 9)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 8)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 7)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 6)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 5)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 4)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 3)).day);
    }

    return getDates;
  }

}