import 'package:flutter/material.dart';
class NavBar extends StatefulWidget{
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int tabActive = 0;
  void setNavBarActive(int x){
    setState(() {
      tabActive = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _getNavBar(context),
    );
  }

  _getNavBar(context){
    return Stack(children: <Widget>[
      Positioned(
        bottom: 0,
        child: ClipPath(
          clipper: NavBarClipper(),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo,
                  Colors.indigo.shade800,
                ]
              )
            ),
          ),
        ))
    ,
    Positioned(
      bottom: 45,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildNavItem(Icons.home,tabActive == 0, 0),
          SizedBox(width: 1),
          _buildNavItem(Icons.add,tabActive == 1, 1),
          SizedBox(width: 1),
          _buildNavItem(Icons.settings,tabActive == 2, 2),
        ],
        )
    )]);
  }

// Nav buttons 
  _buildNavItem(IconData icon, bool active, int num) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: active? Colors.indigo.shade800: Colors.white,
      onPressed: ()=>{ setNavBarActive(num)},
      child: CircleAvatar(
        radius: active ? 30: 17,
        backgroundColor: active? Colors.indigo.shade500 : Colors.indigo.shade500,
        child: CircleAvatar(
            radius: active ? 30: 15,
            backgroundColor: active?  Colors.indigo.shade500  : Colors.white,
            child: Icon(icon, color: active? Colors.white : Colors.indigo.shade500),
          ),
      ),
    );
  }
}

// Create Clipper wave
class NavBarClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    //shape lower wave 1
    path.cubicTo(sw/12, 0, sw/12, 2*sh/5, 2*sw/12, 2*sh/5);
    path.cubicTo(3*sw/12, 2*sh/5, 3*sw/12, 0, 4*sw/12, 0);
    //shape lower wave 2
    path.cubicTo(5*sw/12, 0, 5*sw/12, 2*sh/5, 6*sw/12, 2*sh/5);
    path.cubicTo(7*sw/12, 2*sh/5, 7*sw/12, 0, 8*sw/12, 0);
    //shape lower wave 3
    path.cubicTo(9*sw/12, 0, 9*sw/12, 2*sh/5, 10*sw/12, 2*sh/5);
    path.cubicTo(11*sw/12, 2*sh/5, 11*sw/12, 0, sw, 0);

    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}