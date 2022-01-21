import 'package:flutter/material.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

// ignore: must_be_immutable
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
            ? Text(
                label!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 0.15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              )
            : Text(''),
        SizedBox(
          height: 6,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
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
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                letterSpacing: 0.15,
                height: 1.8,
              ),
              decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  hintText: hintText,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: InputBorder.none)),
        )
      ],
    );
  }
}
