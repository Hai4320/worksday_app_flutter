import 'package:flutter/material.dart';
import 'package:worksday_app/screens/start/start.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/screens/app.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      },
      initialRoute: '/',
    );
  }
}

