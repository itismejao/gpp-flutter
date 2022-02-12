import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasLinhaRepository {
  ApiService api;

  PecasLinhaRepository({
    required this.api,
  });

  Future<bool> create(PecasLinhaModel pecasLinhaModel) async {
    print(jsonEncode(pecasLinhaModel.toJson()));

    Response response = await api.post('/peca-linha', pecasLinhaModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao inserir uma linha';
    }
  }
}
