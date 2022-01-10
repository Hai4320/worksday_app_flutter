import 'package:worksday_app/models/task_model.dart';
import 'package:intl/intl.dart';
class AppDatas{
  static List<Task> task_data = [
    Task(0, "0", "Công việc X", "Home", 2, 5),
    Task(1, "0", "Họp nhóm ABC", "School", 1, 5),
    Task(2, "0", "Mua thức ăn", "Home", 2, -1),
    Task(3, "0", "Check mail", "Home", 3, -1),
    Task(4, "0", "Gọi điện cho mẹ", "Home", 2, 5),
    Task(5, "0", "Chùi tolet", "Home", 3, 0),
    Task(6, "1", "Mua bàn chải mới", "Home", 2, 0),
    Task(7, "1", "Đi bơi chìu chủ nhật", "Sports", 2, 5),
    Task(8, "2", "Gửi Báo cáo cho sếp", "Company", 2, 30),
    Task(9, "2", "Leo núi Q7", "Sport", 2, 5),

  ];
}