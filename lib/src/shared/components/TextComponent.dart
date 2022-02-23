import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String data;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  const TextComponent(this.data,
      {Key? key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.letterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Text(
      data,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 16 * media.textScaleFactor,
        letterSpacing: letterSpacing ?? 0.15,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
