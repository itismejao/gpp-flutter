import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_cor_model.dart';

import 'cores_detail_view.dart';

class PopUpEditar {
  static popUpPeca(context, Widget pagina) {
    // double height = 600;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Dialog(
      // insetPadding: EdgeInsets.all(200),
      child: Container(
        width: width - 300,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(20),
        child: pagina,
      ),
    );
  }
}
