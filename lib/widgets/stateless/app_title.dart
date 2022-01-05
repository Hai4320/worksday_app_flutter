import 'package:flutter/material.dart';

class TitleBarApp extends StatelessWidget {
  final String text_1;
  final String text_2;
  double size = 30;
  final Color color;
  TitleBarApp({ Key? key, required this.text_1, required this.text_2, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text_1,style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold)), 
          const TextSpan(text: "  "),
          TextSpan(text: text_2,style: TextStyle(color: color, fontSize: size+4, fontWeight: FontWeight.w300)), 
        ]
      )
      
    );
  }
}