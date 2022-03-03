import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class NotifyController {
  BuildContext context;

  NotifyController({
    required this.context,
  });

  void error2(String message) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void error(String? message) {
    // if (message != null) {
    //   final snackBar = SnackBar(
    //       duration: const Duration(seconds: 5),
    //       backgroundColor: Colors.red,
    //       content: Text(message));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  void sucess(String message) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.green,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> alert(String message) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text(message),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 25, bottom: 15, right: 25),
                  child: Text(
                    "Não",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: secundaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 25, bottom: 15, right: 25),
                  child: Text(
                    "Sim",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result == null) {
      return false;
    } else {
      return result;
    }
  }
}
