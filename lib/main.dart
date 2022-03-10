import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worksday_app/models/task.dart';
import 'package:worksday_app/screens/start/start.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/screens/app.dart';
import 'package:worksday_app/screens/form_add.dart';
import 'package:worksday_app/screens/voice_add.dart';

import 'models/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TypeTaskAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<TypeTask>("typetask");
  await Hive.openBox<Task>('task');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Box<TypeTask> typeBox = Hive.box('typetask');
    if (typeBox.isEmpty) {
      for (int i = 0; i < AppDatas.initTypes.length; i++) {
        var temp = AppDatas.initTypes[i];
        temp.setDefault(true);
        typeBox.put(i, temp);
      }
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      routes: {
        '/': (context) => const Start(),
        '/App': (context) => const AppWithNav(),
        '/AddTask': (context) => const AddForm(),
        '/VoiceAdd': (context) => const VoiceAdd(),
      },
      initialRoute: '/',
    );
  }
}
