import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_especie_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasEspecieRepository {
  ApiService api;

  PecasEspecieRepository({
    required this.api,
  });

  Future<bool> create(PecasEspecieModel pecasEspecieModel) async {
    print(jsonEncode(pecasEspecieModel.toJson()));

    Response response = await api.post('/peca-especie', pecasEspecieModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao tentar inserir uma espécie';
    }
  }
}
