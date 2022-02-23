import 'package:flutter/material.dart';

class DropdownButtonFormFieldComponent extends StatelessWidget {
  List<DropdownMenuItem> items;
  Widget hint;
  Function onChanged;
  DropdownButtonFormFieldComponent({
    Key? key,
    required this.items,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
            border: InputBorder.none),
        hint: hint,
        items: items,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
