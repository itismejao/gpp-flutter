import 'package:flutter/material.dart';

showError(context, message) {
  final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      content: Text(message));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
