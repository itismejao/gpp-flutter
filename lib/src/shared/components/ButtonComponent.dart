import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class ButtonComponent extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color? color;
  final Icon? icon;

  ButtonComponent({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
            color: color ?? secundaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? Container(),
              SizedBox(
                width: 8,
              ),
              TextComponent(
                text,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
