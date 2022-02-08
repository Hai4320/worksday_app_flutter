import "package:hive/hive.dart";
import 'package:intl/intl.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String time;

  @HiveField(1)
  String taskname;

  @HiveField(2)
  int priority;

  @HiveField(3)
  int type;

  @HiveField(4)
  String more="";

  @HiveField(5)
  int repeat=0;

  @HiveField(6)
  String image="";

  @HiveField(7) 
  String audio="";

  @HiveField(8)
  int noticetime;

  @HiveField(9)
  bool isDone = false;

  @HiveField(10)
  bool isShown = true;

  @HiveField(11)
  List<bool> repeatWeek = List<bool>.generate(7, (index) => false);

  @HiveField(12)
  List<bool> repeatMonth = List<bool>.generate(31, (index) => false);

  List<String> dayOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];

  Task( this.time, this.taskname, this.type, this.priority, this.noticetime);
  
  void setRepeat(int indexRepeat, List<bool> li){
    repeat = indexRepeat;
    switch (indexRepeat) {
      case 2: return setRepeatArray(li,7);
      case 3: return setRepeatArray(li,31);
      default: return;
    }
  }
  void setRepeatArray(List<bool> li, int days){
    int size = li.length<days? li.length:days;
    for (int i = 0; i < size; i++){
      days==7? repeatWeek[i] = li[i]: repeatMonth[i] = li[i];
    }
  }
  String showRepeatDayOfTask() {
    DateTime datetime = DateTime.parse(time);
    switch (repeat) {
      case 0: return DateFormat("dd/MM/yyyy").format(datetime);
      case 1: return "Daily";
      case 2: {
        String result = "Weekly: ";
          for (int i = 0; i < repeatWeek.length; i++) {
            if (repeatWeek[i] == true) {
              result += "${dayOfWeek[i]}, ";
            }
          }
          result = result.substring(0, result.length - 2);
          return result;
      }
      case 3:{
          String result = "Monthly: ";
          for (int i = 0; i < repeatMonth.length; i++) {
            if (repeatMonth[i] == true) {
              result += "${i+1}, ";
            }
          }
          result = result.substring(0, result.length - 2);
          return result;
        }
      default: return DateFormat("dd/MM/yyyy").format(datetime);
    }
  }
}



@HiveType(typeId: 1)
class TypeTask extends HiveObject{

  @HiveField(0)
  late String name;

  @HiveField(1)
  String color="";

  @HiveField(2)
  bool isDefault = false;

  TypeTask({required this.name, required this.color});

  void setDefault(bool x){
    isDefault = x;
  }

}