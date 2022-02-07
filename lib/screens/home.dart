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
        body: ListView(children: [
          _buildTabBar(),
          const SizedBox(
            height: 10,
          ),
          _buildGridTask(),
          const SizedBox(
            height: 100,
          ),
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

  _buildGridTask() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      
      child: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box alltasks, _) {
          if (alltasks.isEmpty) {
            return const Center(
              child: Text('We dont have any type'),
            );
          } else {
            List items = alltasks.values.toList();
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemCount: items.length,
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, i) => _buildTaskItem(items[i],i)
              );
          }
        },
      ),
    );
  }

  _buildTaskItem(Task task,int key) {
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
                  Text(task.showRepeatDayOfTask()),
                ]),
                Row(
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
                    )
                  ]
                ),
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
                      onTap: () {},
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
                      child: Icon(Icons.delete),
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
