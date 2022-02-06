import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worksday_app/models/task.dart';
import 'package:worksday_app/themes/color.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box<TypeTask> typeBox;
  late Box<Task> taskBox;
  int tabIndex = 0;
  

  _buildTabBar(){
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.01,
      ),
      child: Row(
        children: [
          SizedBox(
            height: size.width *0.08,
            width: size.width * 0.96,
            child: ValueListenableBuilder(
              valueListenable: typeBox.listenable(),
              builder: (context, Box allType,_) {
                if (allType.isEmpty) {
                  return const Center(
                    child: Text('We dont have any type'),
                  );
                  } 
                  else {
                  return ListView.builder(
                    itemCount: allType.length,
                    
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index){
                      TypeTask taskData = allType.getAt(index);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                        ),
                        child: InkWell(
                          onTap: (){
                            tabIndex = index;
                            setState(() {});
                          },
                          child: tabIndex != index 
                        ?_buildTab(
                            taskData.name, 
                            AppColors.white,
                            AppColors.primary,
                            AppColors.white,
                            size
                        )
                        : _buildTab(
                            taskData.name, 
                            AppColors.primary,
                            AppColors.white,
                            AppColors.primary,
                            size
                        )
                        )

                      );
                    }, 
                   
                  );
                }
              }
            ),
          )
        ],
        ) 
    );
  }
  _buildTab(
  String categoryName,
  Color firstColor,
  Color secondColor,
  Color textColor,
  Size size,
){
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
  @override
  Widget build(BuildContext context) {

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
            )
            ),
        ),
        ),
      body: _buildTabBar()
    );
      
  }
  @override
  void initState(){

    super.initState();
    typeBox = Hive.box<TypeTask>('typetask');
    taskBox = Hive.box<Task>('task');
  }
}
// ValueListenableBuilder(
//               valueListenable: taskBox.listenable(),
//               builder: (context, Box alltask,_) {
//                 if (alltask.isEmpty) {
//                   return const Center(
//                     child: Text('Empty'),
//                   );
//                 } else {
//                   return ListView.separated(
                    
//                     itemBuilder: (_, index){
//                       Task taskData = alltask.getAt(index);
//                       return ListTile(
//                         title: Text(taskData.taskname),
//                         subtitle: Text(taskData.time),
//                       );
//                     }, 
//                     separatorBuilder: (_,index) => const Divider(), 
//                     itemCount: alltask.length
//                   );
//                 }
//               }
//             ),