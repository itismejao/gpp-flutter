import 'package:flutter/material.dart';

class TitleComponent extends StatelessWidget {
  final String data;
  final Color? color;

  const TitleComponent(
    this.data, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Text(
      data,
      style: TextStyle(
          color: color,
          fontSize: 26 * media.textScaleFactor,
          letterSpacing: 0.20,
          fontWeight: FontWeight.bold),
    );
  }
}
