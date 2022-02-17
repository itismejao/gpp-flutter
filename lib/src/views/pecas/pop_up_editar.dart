
import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_cor_model.dart';

import 'cores_detail_view.dart';

class PopUpEditar {

  static popUpPeca(PecasCorModel pecaCor) {

    double height = 400;

    return Dialog(
      insetPadding: EdgeInsets.all(200),
      child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(20),
          child: CoresDetailView(pecaCor: pecaCor)

      ),
    );
  }

}
