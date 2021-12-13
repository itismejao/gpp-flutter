import 'package:flutter/material.dart';

Color primaryColor = const Color.fromRGBO(4, 4, 145, 1);
Color secundaryColor = const Color.fromRGBO(0, 207, 128, 0.8);
Color backgroundColor = const Color.fromRGBO(195, 184, 184, 0.10);

TextStyle textStyle(
    {Color? color, double? fontSize, FontWeight? fontWeight, double? height}) {
  return TextStyle(
      color: color, fontSize: fontSize, fontWeight: fontWeight, height: height);
}
