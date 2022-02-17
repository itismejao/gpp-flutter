import 'package:flutter/material.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class CheckboxComponent extends StatelessWidget {
  bool value;
  Function onChanged;
  CheckboxComponent({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: primaryColor,
        checkColor: Colors.white,
        value: value,
        onChanged: (value) => onChanged(value));
  }
}
