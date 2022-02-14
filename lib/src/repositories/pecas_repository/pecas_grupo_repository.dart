import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_grupo_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_material_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasGrupoRepository {
  ApiService api;

  PecasGrupoRepository({
    required this.api,
  });

  Future<List<PecasGrupoModel>> buscarTodos() async {
    Response response = await api.get('/peca-grupo-material');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PecasGrupoModel> pecasGrupo = data.map<PecasGrupoModel>((data) => PecasGrupoModel.fromJson(data)).toList();

      return pecasGrupo;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> create(PecasGrupoModel pecasGrupoModel) async {
    print(jsonEncode(pecasGrupoModel.toJson()));

    Response response = await api.post('/peca-grupo-material', pecasGrupoModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao inserir uma linha';
    }
  }
}
