import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worksday_app/models/data.dart';
import 'package:worksday_app/models/task.dart';
import 'package:worksday_app/themes/color.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box<TypeTask> typeBox;
  late Box<Task> taskBox;
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: const Text("Works Day"),
            centerTitle: true,
            shadowColor: Colors.transparent,
            leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  child: const Icon(Icons.list),
                  onTap: () => Navigator.pushNamed(context, "/"),
                )),
          ),
        ),
        body: Column(children: [
          _buildTabBar(),
          const SizedBox(
            height: 10,
          ),
          _buildGridTask(),
        ]));
  }

  @override
  void initState() {
    super.initState();
    typeBox = Hive.box<TypeTask>('typetask');
    taskBox = Hive.box<Task>('task');
  }

  _buildTabBar() {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.01,
        ),
        child: Row(
          children: [
            SizedBox(
              height: size.width * 0.08,
              width: size.width * 0.96,
              child: ValueListenableBuilder(
                  valueListenable: typeBox.listenable(),
                  builder: (context, Box allType, _) {
                    List Types = allType.values.toList();
                    Types.insert(0, TypeTask(name: "All", color: "FFFFFF"));
                    Types.insert(Types.length,
                        TypeTask(name: "Others", color: "FFFFFF"));
                    if (allType.isEmpty) {
                      return const Center(
                        child: Text('We dont have any type'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: Types.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          TypeTask taskData = Types[index];
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                              ),
                              child: InkWell(
                                  onTap: () {
                                    tabIndex = index;
                                    setState(() {});
                                  },
                                  child: tabIndex != index
                                      ? _buildTab(
                                          taskData.name,
                                          AppColors.white,
                                          AppColors.primary,
                                          AppColors.white,
                                          size)
                                      : _buildTab(
                                          taskData.name,
                                          AppColors.primary,
                                          AppColors.white,
                                          AppColors.primary,
                                          size)));
                        },
                      );
                    }
                  }),
            )
          ],
        ));
  }

  _buildTab(
    String categoryName,
    Color firstColor,
    Color secondColor,
    Color textColor,
    Size size,
  ) {
    return Container(
      height: size.width * 0.08,
      width: size.width * 0.18,
      decoration: BoxDecoration(
        color: secondColor,
        border: Border.all(
          color: firstColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Align(
        child: Text(
          categoryName,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
  bool _checkTypeOfTask(Task task) {
    if (tabIndex == 0) return true; // all type
    int typeLength = typeBox.length; 
    var typeOfTab =  (tabIndex > typeLength)? null:  typeBox.getAt(tabIndex-1);
    var typeOfTask = typeBox.get(task.type);
     if (typeOfTab==null&& typeOfTask == null) return true; //other type
    if (typeOfTab==null) return false; // type of tab not found
    if (typeOfTask == null) return false; // type of task not found and type of task is not other type.
    if (typeOfTask.key==typeOfTab.key) return true; // the sample type
    return false; 

  }
  _buildGridTask() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.8,
      child: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box allTasks, _) {
          if (allTasks.isEmpty) {
            return const Center(
              child: Text('We dont have any type'),
            );
          } else {
            List<Task> items=[];
            List<int> itemsIndex= [];
            for (int i=0; i<allTasks.length; i++) {
              Task task = allTasks.getAt(i);
              if (_checkTypeOfTask(task)==true) {
                items.add(task);
                itemsIndex.add(i);
              }
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemCount: items.length,
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, i) => _buildTaskItem(items[i],itemsIndex[i])
              );
          }
        },
      ),
    );
  }

  _buildTaskItem(Task task,int key) {
    var taskType = typeBox.get(task.type);
    DateTime taskTime = DateTime.parse(task.time);
    Color taskColor =
        Color(int.parse("0xff${AppDatas.initPrioritys[task.priority].color}"));
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: taskColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.taskname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    )),
                const SizedBox(height: 10),
                Row(children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.access_alarm,
                      size: 18,
                    ),
                  ),
                  Text(DateFormat("hh:mm a").format(taskTime)),
                ]),
                Row(children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.repeat,
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      task.showRepeatDayOfTask(), 
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                ]),
                Row(children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.notifications,
                      size: 18,
                    ),
                  ),
                  Text(AppDatas.initNotices.where((e)=>e.index == task.noticetime).first.value),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text(
                          "#${AppDatas.initPrioritys[task.priority].name}", 
                        )
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 20,
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5
                        ),
                        decoration: BoxDecoration(
                          color: taskType == null? Colors.transparent: Color(int.parse("0xff${taskType.color}")),
                          border: Border.all(
                            color: AppColors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            "#${taskType==null? "Others" : taskType.name}",
                            overflow: TextOverflow.ellipsis, 
                          )
                        ),
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 5),
                task.image!=""? 
                Expanded(
                  child: Center(child: Image.file(File(task.image)))
                )
                : Container(),
              
              const SizedBox(height: 40)
              ],
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Row(
                children:[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.white,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/AddTask", 
                          arguments: {
                            "task": task,
                            "form": task.image==""?0:2,
                            "key": key,
                          } );
                      },
                      child: Icon(Icons.edit),
                      
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.white,
                      onTap: () {
                        taskBox.deleteAt(key);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  )

                ]
              )
              )
          ],
        ),
      ),
    );
  }
}
