import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_cor_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasCorRepository {
  ApiService api;

  PecasCorRepository({
    required this.api,
  });

  Future<bool> create(PecasCorModel pecasCorModel) async {
    print(jsonEncode(pecasCorModel.toJson()));

    Response response = await api.post('/peca-cor', pecasCorModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar uma cor';
    }
  }

  Future<List<PecasCorModel>> buscarTodos() async {
    Response response = await api.get('/peca-cor');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PecasCorModel> pecasCor = data.map<PecasCorModel>((data) => PecasCorModel.fromJson(data)).toList();

      return pecasCor;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}
