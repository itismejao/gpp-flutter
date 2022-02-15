import 'package:flutter/material.dart';

Color primaryColor = const Color.fromRGBO(4, 4, 145, 1);
Color secundaryColor = const Color.fromRGBO(0, 207, 128, 0.8);
Color backgroundColor = const Color.fromRGBO(195, 184, 184, 0.10);

TextStyle textStyle(
    {Color? color, double? fontSize, FontWeight? fontWeight, double? height}) {
  return TextStyle(
      color: color, fontSize: fontSize, fontWeight: fontWeight, height: height);
}

InputDecoration inputDecoration(hintText, prefixIcon, {suffixIcon}) {
  return InputDecoration(
      contentPadding: EdgeInsets.all(12),
      isDense: true,
      prefixIcon: prefixIcon,
      prefixIconColor: Colors.grey.shade400,
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: textStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        height: 1.8,
        fontSize: 12,
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade300)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade300)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.green,
          width: 1.0,
        ),
      ));
}

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shadowColor: Colors.transparent, elevation: 0, primary: primaryColor);
