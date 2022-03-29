import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

import '../shared/components/TextButtonComponent.dart';

class Notificacao {
  static confirmacao(String mensagem) async {
    return await Get.dialog(AlertDialog(
      title: TextComponent(
        'Confirmação',
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      content: TextComponent(
        mensagem,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.normal,
      ),
      actions: <Widget>[
        Container(
          width: Get.width * 0.40,
          height: Get.height * 0.05,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButtonComponent(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    text: 'Não',
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButtonComponent(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      text: 'Sim')
                ],
              )
            ],
          ),
        )
      ],
    ));
  }

  static void snackBar(String mensagem) {
    Get.snackbar('Mensagem', mensagem,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: secundaryColor,
        borderRadius: 5,
        margin: EdgeInsets.only(left: Get.width * 0.8, bottom: 20, right: 20),
        maxWidth: Get.width * 0.6);
  }
}
