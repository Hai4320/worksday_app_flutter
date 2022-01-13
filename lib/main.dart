import 'package:flutter/material.dart';
import 'package:worksday_app/screens/start/start.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/screens/app.dart';
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
      routes: {
        '/': (context) => Start(),
        '/App': (context) => AppWithNav(),
      },
      initialRoute: '/',
    );
  }
}

