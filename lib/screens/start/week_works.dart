import 'package:flutter/material.dart';
import "package:worksday_app/models/task_model.dart";
import "package:worksday_app/models/data.dart";
import 'package:worksday_app/themes/color.dart'; 

class WeekWorks extends StatefulWidget {
  const WeekWorks({ Key? key }) : super(key: key);  

  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<WeekWorks> {
  
  final List<String> dayOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  @override
  Widget build(BuildContext context) {
    int today = DateTime.now().weekday;

    double scWidth = MediaQuery.of(context).size.width;
    createListTaskEx(int length){
      Task task_ex = Task(0, "0", "Công việc X", "Home", 2, 5); 
      List<Task> listTask = List<Task>.generate(length, (index) => task_ex);
      return listTask;
    }
    
    List<List<Task>> tasksWeek= [
      createListTaskEx(3),
      createListTaskEx(1),
      createListTaskEx(2),
      createListTaskEx(5),
      createListTaskEx(0),
      createListTaskEx(3),
      createListTaskEx(5)
    ];
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: AppColors.semi_white,
          borderRadius: BorderRadius.circular(5),
        ),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, indexDay) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 30,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 10, right:15),
                child: Row(
                  children: [
                    (
                      indexDay <= today-1 
                      ? const Icon(Icons.radio_button_checked, color: Colors.red)
                      : const Icon(Icons.radio_button_unchecked, color: Colors.grey)
                    ),
                    const SizedBox(width: 2,),
                    Text(
                      dayOfWeek[indexDay],
                      style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                  ],  
                ),
              ),
              Container(
                width: scWidth-200,
                height: tasksWeek[indexDay].length*20 + 20,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 10, 
                      offset: const Offset(6,6)
                    )
                  ]
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: tasksWeek[indexDay].map(
                    (e) => Text(e.taskname)
                  ).toList()
                ),
              )
            ],
          ),
        )
        )
      
    );
  }
}