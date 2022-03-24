import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class CardWidget extends StatelessWidget {
  final Widget widget;
  const CardWidget({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 9,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
        border: Border(
          left: BorderSide(
            color: secundaryColor,
            width: 7.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget,
      ),
    );
  }
}
