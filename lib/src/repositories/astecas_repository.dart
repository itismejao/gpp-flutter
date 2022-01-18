import 'dart:convert';


import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/shared/exceptions/asteca_exception.dart';

import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:http/http.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AstecaRepository {
  ApiService api;

  AstecaRepository({
    required this.api,
  });

  Future<AstecaModel> fetch(String id) async {
    Response response = await api.get('/astecas/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return AstecaModel.fromJson(data.first.first);
    } else {
      throw AstecaException("Não foi possível encontrar astecas !");
    }
  }

  Future<List<AstecaModel>> fetchAll() async {
    Response response = await api.get('/astecas');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<AstecaModel> Asteca = data.first
          .map<AstecaModel>((data) => AstecaModel.fromJson(data))
          .toList();
      return Asteca;
    } else {
      throw AstecaException("Não foi possível encontrar astecas !");
    }
  }

  Future<List<SubFuncionalitiesModel>> fetchSubFuncionalities(
      AstecaModel Asteca) async {
    Response response = await api.get(
        '/astecas/itensfuncionalidades/' + Asteca.id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalitiesModel> subFuncionalities = data.first
          .map<SubFuncionalitiesModel>(
              (data) => SubFuncionalitiesModel.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      throw FuncionalitiesException(
          "Não foi possivel encontrar itens de funcionalidades relacionadas ao astecas !");
    }
  }

  Future<bool> updateDepartmentSubFuncionalities(AstecaModel Asteca,
      List<SubFuncionalitiesModel> subFuncionalities) async {
    List<Map<String, dynamic>> dataSend = subFuncionalities
        .map((subFuncionalitie) => subFuncionalitie.toJson())
        .toList();

    Response response = await api.put(
        '/astecas/itensfuncionalidades/' + Asteca.id.toString(),
        dataSend);

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      return throw AstecaException(
          "Funcionalidades do departamento foram atualizadas !");
    }
  }

  Future<bool> create(AstecaModel Asteca) async {
    Response response = await api.post('/astecas', Asteca.toJson());
    print(Asteca.toJson());
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw AstecaException(error);
    }
  }

  Future<bool> delete(AstecaModel Asteca) async {
    Response response = await api.delete(
      '/astecas/' + Asteca.id.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw AstecaException(error);
    }
  }

  Future<bool> update(AstecaModel Asteca) async {
    Response response = await api.put(
        '/astecas/' + Asteca.id.toString(), Asteca.toJson());

    print(Asteca.toJson());
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw AstecaException("Departamento não foi atualizado!");
    }
  }
}
