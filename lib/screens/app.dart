import 'package:flutter/material.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/widgets/stateful/navbar.dart';


class AppWithNav extends StatefulWidget {
  const AppWithNav({ Key? key }) : super(key: key);

  @override
  _AppWithNavState createState() => _AppWithNavState();
}

class _AppWithNavState extends State<AppWithNav> {
  List<String> Tab = ["Home","Add","Setting"];
  int indexTab = 0;
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
            Center(
              
              child: Text(
                Tab[indexTab],
                style: TextStyle(color: AppColors.black),
                ),
            ),
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