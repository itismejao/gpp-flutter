import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_material_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasMaterialRepository {
  ApiService api;

  PecasMaterialRepository({
    required this.api,
  });

  Future<List<PecasMaterialModel>> buscarTodos() async {
    Response response = await api.get('/peca-material-fabricacao');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PecasMaterialModel> pecasMaterial = data.map<PecasMaterialModel>((data) => PecasMaterialModel.fromJson(data)).toList();

      return pecasMaterial;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> create(PecasMaterialModel pecasLinhaModel) async {
    print(jsonEncode(pecasLinhaModel.toJson()));

    Response response = await api.post('/peca-material-fabricacao', pecasLinhaModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao inserir um Material';
    }
  }

  Future<bool> excluir(PecasMaterialModel pecasMaterialModel) async {
    Response response =
        await api.delete('/peca-material-fabricacao/' + pecasMaterialModel.id_peca_material_fabricacao.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
}
