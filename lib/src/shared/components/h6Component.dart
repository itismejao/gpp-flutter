import 'package:flutter/material.dart';

class H6Component extends StatelessWidget {
  String text;
  Color? color;
  H6Component({
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
          fontWeight: FontWeight.w500,
          fontSize: 20,
          letterSpacing: 0.15),
    );
  }
}
