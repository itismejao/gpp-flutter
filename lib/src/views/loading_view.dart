import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: secundaryColor,
            )),
      ],
    );
  }
}
