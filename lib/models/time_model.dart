class TaskTime{
  int minute;
  int hour;
  int day;
  int month;
  int year;
  // 0 = none, 1: every day, 2: every week, 3: every month, 4: every year, 5: some day of week.
  int repeat = 0;
  List<bool> weekday = [false, false, false, false, false, false, false];
  TaskTime(this.minute, this.hour, this.day, this.month, this.year);
  void setRepeat(int repeat, List<bool> weekday){
    this.repeat = repeat;
    if (repeat==5) this.weekday = weekday;
  }

}