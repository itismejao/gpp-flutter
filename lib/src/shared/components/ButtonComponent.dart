import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

class ButtonComponent extends StatefulWidget {
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
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  bool _onHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: MouseRegion(
        onHover: ((event) {
          setState(() {
            _onHover = true;
          });
        }),
        onExit: (_) {
          setState(() {
            _onHover = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: _onHover ? 42 : 40,
          width: _onHover ? 182 : 180,
          curve: Curves.easeIn,
          decoration: BoxDecoration(
              color: widget.color ?? secundaryColor,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon ?? Container(),
                SizedBox(
                  width: 8,
                ),
                TextComponent(
                  widget.text,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
