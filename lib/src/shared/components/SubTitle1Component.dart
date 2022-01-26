import 'package:flutter/material.dart';

class SubTitle1Component extends StatelessWidget {
  String text;
  Color? color;
  SubTitle1Component({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          letterSpacing: 0.15),
    );
  }
}
