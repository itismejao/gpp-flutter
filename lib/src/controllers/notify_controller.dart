import 'package:flutter/material.dart';

class NotifyController {
  BuildContext context;

  NotifyController({
    required this.context,
  });

  void error(String message) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void sucess(String message) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.green,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> alert(String message) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(false); // dismisses only the dialog and returns false
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(true); // dismisses only the dialog and returns true
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
