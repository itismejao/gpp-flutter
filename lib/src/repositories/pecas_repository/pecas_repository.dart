import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasRepository {
  ApiService api;

  PecasRepository({
    required this.api,
  });

  Future<bool> create(PecasModel pecas) async {
    print(jsonEncode(pecas.toJson()));
    Response response = await api.post('/pecas', pecas.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar uma peça';
    }
  }

  Future<List<PecasModel>> buscarTodos() async {
    Response response = await api.get('/pecas');

    //print(response.body);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      //print(data["data"]);
      // print(jsonDecode(response.body));

      // Fazer trazer array no model
      List<PecasModel> pecas = data["data"].map<PecasModel>((data) => PecasModel.fromJson(data)).toList();

      return pecas;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}
