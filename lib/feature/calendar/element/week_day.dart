enum WeekDay {
  monday(DateTime.monday, 'Mon'),
  tuesday(DateTime.tuesday, 'Tue'),
  wednesday(DateTime.wednesday, 'Wed'),
  thursday(DateTime.thursday, 'Thu'),
  friday(DateTime.friday, 'Fri'),
  saturday(DateTime.saturday, 'Sat'),
  sunday(DateTime.sunday, 'Sun');

  factory WeekDay.fromIntWeekday(int weekDay) {
    return WeekDay.values[weekDay - 1];
  }
  factory WeekDay.fromDateTime(DateTime day) {
    return WeekDay.values[day.weekday - 1];
  }

  final int number;
  final String symbol;
  const WeekDay(this.number, this.symbol);

  @override
  String toString() => '$name ($number)';
}
