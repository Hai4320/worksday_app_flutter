import 'package:flutter/material.dart';
import 'package:worksday_app/models/data.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/themes/images.dart';
import 'package:phlox_animations/phlox_animations.dart';

class Add extends StatelessWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> add_list = [
      {"name": 'Nomal create', "icon": Icons.add, "color":AppColors.safe, "action": "/AddTask"},
      {"name": 'Advanced create', "icon": Icons.note_add, "color":AppColors.safe,"action":"/AddTask"},
      {"name": 'Voice create', "icon": Icons.mic, "color":AppColors.safe,"action": "/VoiceAdd"},
      {"name": 'With media create', "icon": Icons.photo_camera_back, "color": AppColors.safe,"action": "/AddTask"},
    ];
    var xxx = {
      "name": 'Nomal create', "icon": Icons.add, "color":AppColors.safe
    };
    return Scaffold(
      body: PhloxAnimations(
        fromOpacity: 0,
        fromY: -50,
        duration: const Duration(milliseconds: 500),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: false,
              expandedHeight: 150,
              actions: [
                const Icon(Icons.settings, color: Colors.black),
                const SizedBox(width: 5,)
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Create Task"),
                centerTitle: true,
                background: Image.asset(AppImage.back_1, fit: BoxFit.cover,),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(add_list.length, (idx) {
                  return Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Card(
                  
                      child: ListTile(
                        iconColor: add_list[idx]["color"],
                        leading: Icon(add_list[idx]["icon"]),
                        title: Text(add_list[idx]["name"]),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: ()=> Navigator.pushNamed(context, add_list[idx]["action"]),
                      ),
                    ),
                  );
                })
              )
              )
          ],
          
        ),
      ),
    );
  }
}