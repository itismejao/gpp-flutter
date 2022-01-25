import 'package:flutter/material.dart';

import 'package:gpp/src/shared/components/text_component.dart';

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
  final TextInputType? keyboardType;
  final int? maxLines;
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
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? TextComponent(label!) : Text(''),
        SizedBox(
          height: 6,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
              maxLines: maxLines,
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
                  color: Colors.black,
                  fontSize: 16 * media.textScaleFactor,
                  letterSpacing: 0.15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  hintText: hintText,
                  contentPadding:
                      EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  border: InputBorder.none)),
        )
      ],
    );
  }
}
