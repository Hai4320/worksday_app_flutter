import 'package:worksday_app/models/priority.dart';
import 'package:worksday_app/models/task.dart';
class AppDatas{
  static List<Task> task_data = [
    Task("0", "Công việc X", 1, 2, 5),
    Task("0", "Họp nhóm ABC", 4, 1, 5),
    Task("0", "Mua thức ăn", 1, 2, -1),
    Task("0", "Check mail", 1, 3, -1),
    Task("0", "Gọi điện cho mẹ", 1, 2, 5),
    Task("0", "Chùi tolet", 1, 3, 0),
    Task("1", "Mua bàn chải mới", 1, 2, 0),
    Task("1", "Đi bơi chìu chủ nhật", 2, 2, 5),
    Task("2", "Gửi Báo cáo cho sếp", 3, 2, 30),
    Task("2", "Leo núi Q7", 2, 2, 5),
  ];

  static final List<Priority> initPrioritys = [
    Priority(0,"important","FF5959"),
    Priority(1,"moderate","FFE400"),
    Priority(2,"safe","64C9CF"),
    Priority(3,"unimportant","8CA1A5"),
  ];

  static final List<AppValue> initRepeats = [
    AppValue(index: 0, value:"None"),
    AppValue(index: 1, value:"Daily"),
    AppValue(index: 2, value:"Weekly"),
    AppValue(index: 3, value:"Monthly"),

  ];
  static final List<AppValue> initNotices = [
    AppValue(index: -1, value: "None"),
    AppValue(index: 0, value: "In time"),
    AppValue(index: 5, value: "5'"),
    AppValue(index: 10, value: "10'"),
    AppValue(index: 15, value: "15'"),
    AppValue(index: 30, value: "30'"),
    AppValue(index: 60, value: "1h"),
    
  ];
}
class AppValue{
  int index;
  String value;
  AppValue({required this.index, required this.value});
}