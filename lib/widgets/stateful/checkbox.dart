import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;

  const CustomCheckbox(this.isChecked, this.size, this.iconSize, this.selectedColor, this.selectedIconColor, {Key? key}) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected ? widget.selectedColor: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: _isSelected ? null : Border.all(
            color: Colors.grey,
            width: 2.0,
          )
        ),
        width: widget.size,
        height: widget.size,
        child: _isSelected ? Icon(
          Icons.check,
          color: widget.selectedIconColor,
          size: widget.iconSize,
        ) : null,
      ),
    );
  }
}