import 'package:flutter/material.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/widgets/stateful/navbar.dart';
import 'package:worksday_app/screens/add.dart';
import 'package:worksday_app/screens/home.dart';
import 'package:worksday_app/screens/setting.dart';


class AppWithNav extends StatefulWidget {
  const AppWithNav({ Key? key }) : super(key: key);

  @override
  _AppWithNavState createState() => _AppWithNavState();
}

class _AppWithNavState extends State<AppWithNav> {
  int indexTab = 0;
  renderTab(int index) {
    switch(index) {
      case 0: return const Home();
      case 1: return const Add();
      case 2: return const Setting();
      default: return const Home();
    }
  }
  onChangedTab(int x){
    
    setState((){  
     indexTab = x;
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        child: Stack(
          children: [
            renderTab(indexTab),
            NavBar(
              indexTab: indexTab,
              onChangedTab: onChangedTab,
            ),
          ],
        ),
      ),

    );
  }
}