import 'package:flutter/material.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class ButtonPrimaryComponent extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color? color;
  Icon? icon;

  ButtonPrimaryComponent({
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
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? Container(),
              SizedBox(
                width: 8,
              ),
              Text(text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.15,
                      height: 2)),
            ],
          ),
        ),
      ),
    );
  }
}
