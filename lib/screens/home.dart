import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worksday_app/models/task.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box<TypeTask> typeBox;
  late Box<Task> taskBox;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box alltask,_) {
          if (alltask.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.separated(

              itemBuilder: (_, index){
                Task taskData = alltask.getAt(index);
                return ListTile(
                  title: Text(taskData.taskname),
                  subtitle: Text(taskData.time),
                );
              }, 
              separatorBuilder: (_,index) => const Divider(), 
              itemCount: alltask.length
            );
          }
        }
      );
      
  }
   @override
  void initState(){

    super.initState();
    typeBox = Hive.box<TypeTask>('typetask');
    taskBox = Hive.box<Task>('task');
  }
}