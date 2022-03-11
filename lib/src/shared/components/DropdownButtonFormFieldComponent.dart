import 'package:flutter/material.dart';

class DropdownButtonFormFieldComponent extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Widget? hint;
  final Function onChanged;
  final String? hintText;
  DropdownButtonFormFieldComponent({
    Key? key,
    required this.items,
    this.hint,
    this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.only(bottom: 5, left: 10),
            border: InputBorder.none),
        hint: hint,
        items: items,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
