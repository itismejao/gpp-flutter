import 'package:flutter/material.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class InputComponent extends StatelessWidget {
  final String label;
  final int? maxLength;
  final Function onSaved;
  final Function validator;
  final String hintText;
  final Icon prefixIcon;
  final dynamic? suffixIcon;
  final bool? obscureText;
  const InputComponent({
    Key? key,
    required this.label,
    this.maxLength,
    required this.onSaved,
    required this.validator,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: textStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        TextFormField(
          obscureText: obscureText ?? false,
          maxLength: maxLength,
          onSaved: (value) => onSaved(value),
          validator: (value) => validator(value),
          keyboardType: TextInputType.number,
          style: textStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 14,
              height: 1.8),
          decoration:
              inputDecoration(hintText, prefixIcon, suffixIcon: suffixIcon),
        )
      ],
    );
  }
}
