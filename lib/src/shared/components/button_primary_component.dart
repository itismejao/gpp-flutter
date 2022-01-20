import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class ButtonPrimaryComponent extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ButtonPrimaryComponent({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            elevation: 0,
            primary: primaryColor),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(text,
              style:
                  textStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ));
  }
}
