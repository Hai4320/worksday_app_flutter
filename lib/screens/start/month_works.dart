import 'package:flutter/material.dart';
import 'package:worksday_app/themes/color.dart'; 
import "package:worksday_app/models/task_model.dart";

class MonthWorks extends StatefulWidget {
  const MonthWorks({ Key? key }) : super(key: key);

  @override
  _MonthWorksState createState() => _MonthWorksState();
}

class _MonthWorksState extends State<MonthWorks> {
  taskEx(String name , int day){
      Task task_ex = Task(0, day.toString() , name, "Home", 1, 5);   
      return task_ex;
  }
  @override
  
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<Task> listTask = [
      taskEx("Xem phim", 1),taskEx("Da Bong", 4),taskEx("boi", 6),
      taskEx("Xem phim", 15),taskEx("Boi", 15),taskEx("Deadline", 15),
      taskEx("Xem kich", 19),taskEx("Mua quan ao", 20),taskEx("Mua ban phim", 20),
      taskEx("Don nha", 21),taskEx("Hop dinh ki", 22),taskEx("Xem phim", 30)];
    return Container(
      height: 450,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.semi_white,
          borderRadius: BorderRadius.circular(5),
        ),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: ListView.builder(
        itemCount: listTask.length,
        itemBuilder: (context, indexItem) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (
              indexItem==0||listTask[indexItem].time!=listTask[indexItem-1].time
              ? Container(
                alignment: Alignment.center,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.gray
                ),
                child: Text(
                  
                  listTask[indexItem].time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
              )
              : Container()
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 2),
              child: Text(
                listTask[indexItem].taskname, 
                style: const TextStyle(
                  fontSize: 15, 
                )  
              ),
            )
          ],
        )
      )
    );
  }
}