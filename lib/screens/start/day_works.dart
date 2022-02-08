import 'package:flutter/material.dart';
import "package:worksday_app/models/data.dart";
import 'package:worksday_app/models/task.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/widgets/stateful/checkbox.dart';


class DayWorks extends StatefulWidget {
  const DayWorks({ Key? key }) : super(key: key);

  @override
  _DayWorksState createState() => _DayWorksState();
}

class _DayWorksState extends State<DayWorks> {
  final List<Task> tasks_day = AppDatas.task_data.where((i) => i.time=="0").toList();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.6,
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: ListView.builder(
        itemCount: tasks_day.length-1,
        itemBuilder:(context, index) =>  createTaskItem(index)
      )
    );
  }

  createTaskItem(int index){
    String taskDetail = tasks_day[index].taskname;
    int taskNoticeTime = tasks_day[index].noticetime;
    List<String> taskTime = ["08:00 AM", "09:00 AM", "10:30 AM", "07:15 PM","9:30 PM",];
    Color taskColor;
    bool taskDone = tasks_day[index].isDone;


    createAlarm(int noticetime) {
      if (noticetime == -1) {
        return Container();
      } else {
        return Container(
        margin: const EdgeInsets.only(left: 10),
        width: 50,
        height: 24,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius:BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              noticetime == 0?"": (noticetime.toString()+"'"),
              style: TextStyle(color: AppColors.white),),
            const Icon(Icons.notifications,size: 15, color: Colors.white,),
          ])
      );
      }
      
      
    }
    switch (tasks_day[index].priority){
      case 1: taskColor = AppColors.important; break;
      case 2: taskColor = AppColors.moderate; break;
      case 3: taskColor = AppColors.safe; break;
      case 4: taskColor = AppColors.gray; break;
      default: taskColor = AppColors.gray;        
    }
    return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.white, 
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 9,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],  
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 5,
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  color: taskColor 
                )
              ),

              Container(
                width: 200,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: Text(
                      taskDetail, 
                      style: TextStyle(color: AppColors.black, fontSize: 17, fontWeight: FontWeight.bold), 
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      ),
                    ),
                    Row(
                      
                      children: [
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            taskTime[index], 
                            style: TextStyle(color: AppColors.white)
                          ),                      
                        ),

                        createAlarm(taskNoticeTime)


                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right:10),
                child: CustomCheckbox(taskDone, 25, 20, AppColors.green, AppColors.white)
              )
            ],  
            )
        );
  }
}