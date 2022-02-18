import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gpp/src/shared/components/TextComponent.dart';

class InputComponent extends StatelessWidget {
  final String? label;
  String? initialValue;
  final int? maxLength;
  final Function? onSaved;
  final Function? validator;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final String? hintText;
  final Icon? prefixIcon;
  final dynamic suffixIcon;
  final bool? obscureText;
  final bool? enable;
  final TextInputType? keyboardType;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;
  InputComponent({
    Key? key,
    this.label,
    this.initialValue,
    this.maxLength,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.enable,
    this.keyboardType,
    this.maxLines,
    this.inputFormatter,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    if (label != null) {
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
                inputFormatters: inputFormatter,
                maxLines: maxLines,
                initialValue: initialValue,
                enabled: enable,
                obscureText: obscureText ?? false,
                maxLength: maxLength,
                onFieldSubmitted: (value) => {
                      if (onFieldSubmitted != null) {onFieldSubmitted!(value)}
                    },
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
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
            controller: controller,
            inputFormatters: inputFormatter,
            maxLines: maxLines,
            initialValue: initialValue,
            enabled: enable,
            obscureText: obscureText ?? false,
            maxLength: maxLength,
            onFieldSubmitted: (value) => {
                  if (onFieldSubmitted != null) {onFieldSubmitted!(value)}
                },
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
                contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                border: InputBorder.none)),
      );
    }
  }
}
