import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_especie_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasLinhaRepository {
  ApiService api;

  PecasLinhaRepository({
    required this.api,
  });

  Future<List<PecasLinhaModel>> buscarTodos() async {
    Response response = await api.get('/peca-linha');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PecasLinhaModel> pecasLinha = data.map<PecasLinhaModel>((data) => PecasLinhaModel.fromJson(data)).toList();

      return pecasLinha;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<List<PecasLinhaModel>> buscarEspecieVinculada(int codigo) async {
    Response response = await api.get('/peca-linha/' + codigo.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      // print(jsonDecode(response.body));

      // List<PecasLinhaModel> pecasEspecie = data.map<PecasLinhaModel>((data) => PecasLinhaModel.fromJson(data)).toList();
      List<PecasLinhaModel> pecasEspecie = data["data"].map<PecasLinhaModel>((data) => PecasLinhaModel.fromJson(data)).toList();

      print(pecasEspecie);

      return pecasEspecie;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> inserir(PecasLinhaModel pecasLinhaModel) async {
    print(jsonEncode(pecasLinhaModel.toJson()));

    Response response = await api.post('/peca-linha', pecasLinhaModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao inserir uma linha';
    }
  }

  Future<bool> excluir(PecasLinhaModel pecasLinhaModel) async {
    Response response = await api.delete('/peca-linha/' + pecasLinhaModel.id_peca_linha.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> editar(PecasLinhaModel pecasLinhaModel) async {
    print(jsonEncode(pecasLinhaModel.toJson()));

    Response response = await api.put('/peca-linha/${pecasLinhaModel.id_peca_linha}', pecasLinhaModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao editar uma cor';
    }
  }
}
