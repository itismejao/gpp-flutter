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
      contentPadding: const EdgeInsets.all(10.0),
      prefixIcon: prefixIcon,
      prefixIconColor: Colors.grey.shade400,
      suffixIcon: suffixIcon != null ? suffixIcon : null,
      hintText: hintText,
      hintStyle: textStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 14,
          height: 1.8),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade300)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.0,
        ),
      ));
}
