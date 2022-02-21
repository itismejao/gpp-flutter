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

  Future<bool> criar(PecasModel pecas) async {
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

  Future<bool> editar(PecasModel pecasModel) async {
    print(jsonEncode(pecasModel.toJson()));

    Response response = await api.put('/pecas/${pecasModel.id_peca}', pecasModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao editar uma cor';
    }
  }

  Future<PecasModel> buscar(String codigo) async {
    Response response = await api.get('/pecas/' + codigo);

    print(response.body);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      print('buscou peca');
      print(data);

      PecasModel pecas = PecasModel.fromJson(data);

      print('buscou peca 2');
      print(pecas.id_peca);

      return pecas;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> excluir(PecasModel pecasModel) async {
    Response response = await api.delete('/pecas/' + pecasModel.id_peca.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
}
