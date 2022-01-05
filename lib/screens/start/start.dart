import 'package:flutter/material.dart';
import 'package:worksday_app/themes/color.dart';
import 'package:worksday_app/themes/images.dart';
import 'package:worksday_app/widgets/stateless/app_title.dart';
import 'package:worksday_app/screens/start/day_works.dart';
import 'package:intl/intl.dart';
class Start extends StatefulWidget {
  const Start({ Key? key }) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start>{
  List timePage = ["Day", "Week", "Month"];
  DateTime  now = DateTime.now();
  DateFormat formatter1 = DateFormat('LLL dd, yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (_,indexPage){
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImage.back_3
                ),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: (){},
                      child: const Icon(Icons.notes, color: Colors.white, size: 30),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleBarApp(text_1: "Works", text_2: timePage[indexPage]),
                      Row(
                        children: List.generate(3, (indexDot){
                          return Container(
                            margin: const EdgeInsets.only(left: 2),
                            width: indexPage==indexDot ? 24: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: indexPage==indexDot ? AppColors.primary: AppColors.white.withOpacity(0.8),
                            )
                          );
                        })
                      )
                    ]
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left:10, top:10),
                    child: Text(formatter1.format(now), style: const TextStyle(color: Colors.white, fontSize: 20),)
                  )
                  ,
                  DayWorks(),
                  
                ],
              )
            )
          );
        }
      )
    );
  }
}