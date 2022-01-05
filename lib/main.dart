import 'package:flutter/material.dart';
import 'package:worksday_app/routes/routes.dart';
import 'package:worksday_app/screens/start/start.dart';
import 'package:worksday_app/themes/color.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Start()
    );
  }
}

