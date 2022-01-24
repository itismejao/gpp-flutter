import 'package:flutter/material.dart';

class DropDownComponent extends StatelessWidget {
  Icon? icon;
  String? hintText;
  List<DropdownMenuItem<String>> items;
  DropDownComponent({
    Key? key,
    this.icon,
    this.hintText,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            hintText: hintText,
            prefixIcon: icon,
            hintStyle: TextStyle(fontSize: 12, height: 2),
            border: InputBorder.none),
        items: items.toList(),
        onChanged: (_) {},
      ),
    );
  }
}
