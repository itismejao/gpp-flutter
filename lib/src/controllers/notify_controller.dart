import 'package:flutter/material.dart';

class NotifyController {
  BuildContext context;
  String message;
  NotifyController({
    required this.context,
    required this.message,
  });

  void error() {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void sucess() {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.green,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
