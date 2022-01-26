import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class CheckboxComponent extends StatelessWidget {
  const CheckboxComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: primaryColor,
        checkColor: Colors.white,
        value: false,
        onChanged: (bool? value) {
          //   handleSelectedAll(value),
        });
  }
}
