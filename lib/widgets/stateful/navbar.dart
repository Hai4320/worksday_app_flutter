import 'package:flutter/material.dart';
import 'package:worksday_app/themes/color.dart';
class NavBar extends StatefulWidget{
  final int indexTab;
  final ValueChanged<int> onChangedTab;

  const NavBar({Key? key, required this.indexTab, required this.onChangedTab}) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return _getNavBar(context);
  }

  _getNavBar(context){
    return Stack(
      children: <Widget>[
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
                  AppColors.primary,
                  AppColors.green,
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
          _buildNavItem(Icons.home, 0),
          const SizedBox(width: 1),
          _buildNavItem(Icons.add, 1),
          const SizedBox(width: 1),
          _buildNavItem(Icons.settings, 2),
        ],
        )
    )]);
  }

// Nav buttons 
  _buildNavItem(IconData icon, int num) {

    bool active = widget.indexTab == num;
    return RawMaterialButton( 
      shape: const CircleBorder(),
      fillColor: active? AppColors.primary: AppColors.white,
      onPressed: () => widget.onChangedTab(num),
      child: CircleAvatar(
        radius: active ? 30: 17,
        backgroundColor: active? AppColors.white : AppColors.primary,
        child: CircleAvatar(
            radius: active ? 30: 15,
            backgroundColor: active?  AppColors.primary  : AppColors.white,
            child: Icon(icon, color: active? AppColors.white : AppColors.primary),
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