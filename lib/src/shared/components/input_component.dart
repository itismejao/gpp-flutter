import 'package:flutter/material.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class InputComponent extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final int? maxLength;
  final Function? onSaved;
  final Function? validator;
  final Function? onChanged;
  final String? hintText;
  final Icon? prefixIcon;
  final dynamic suffixIcon;
  final bool? obscureText;
  final bool? enable;
  TextInputType? keyboardType;
  InputComponent({
    Key? key,
    this.label,
    this.initialValue,
    this.maxLength,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.enable,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(label!,
                style:
                    textStyle(color: Colors.black, fontWeight: FontWeight.bold))
            : Text(''),
        SizedBox(
          height: 6,
        ),
        TextFormField(
          initialValue: initialValue,
          enabled: enable,
          obscureText: obscureText ?? false,
          maxLength: maxLength,
          onChanged: (value) => {
            if (onChanged != null) {onChanged!(value)}
          },
          onSaved: (value) => {
            if (onSaved != null) {onSaved!(value)}
          },
          validator: (value) {
            if (validator != null) {
              validator!(value);
            } else {
              return null;
            }
          },
          keyboardType: keyboardType,
          style: textStyle(
              color: Colors.black,
              fontSize: 12,
              height: 1.8,
              fontWeight: FontWeight.bold),
          decoration:
              inputDecoration(hintText, prefixIcon, suffixIcon: suffixIcon),
        )
      ],
    );
  }
}
