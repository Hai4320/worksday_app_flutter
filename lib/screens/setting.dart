import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worksday_app/models/task.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Box<TypeTask> typeBox;

  @override
  Widget build(BuildContext context) {
    TextEditingController typeController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        actions: [
          InkWell(
            child: Icon(Icons.add),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                TextField(
                                  controller: typeController,
                                  decoration: InputDecoration(
                                    hintText: "Type",
                                  ),
                                ),
                                TextField(
                                  controller: colorController,
                                  decoration: InputDecoration(
                                    hintText: "Color",
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    String type_name = typeController.text;
                                    String type_color = colorController.text;
                                    typeBox.add(TypeTask(
                                        name: type_name, color: type_color));
                                    Navigator.pop(context);
                                  },
                                  child: Text("add"),
                                )
                              ],
                            )),
                      ));
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: typeBox.listenable(),
          builder: (context, Box types, _) {
            if (types.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            } else {
              return ListView.separated(
                  itemBuilder: (_, index) {
                    TypeTask typeData = types.getAt(index);
                    return ListTile(
                      title: Text(typeData.name),
                      subtitle: Text(typeData.color),
                      tileColor: Color(int.parse("0xff${typeData.color}")),
                      onLongPress: () {
                        if (!typeData.isDefault) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                        "Do you want to delete this type"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          typeData.delete();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                        }
                      },
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: types.length);
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    typeBox = Hive.box<TypeTask>('typetask');
  }
}
