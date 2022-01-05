import 'dart:convert';

import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/shared/exceptions/subfuncionalities_exception.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class SubFuncionalitiesRepository {
  ApiService api;

  SubFuncionalitiesRepository({
    required this.api,
  });

  Future<List<SubFuncionalitiesModel>> fetch(
      FuncionalitieModel funcionalitie) async {
    Response response =
        await api.get('/itensfuncionalidades/' + funcionalitie.id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalitiesModel> subfuncionalidades = data.first
          .map<SubFuncionalitiesModel>(
              (data) => SubFuncionalitiesModel.fromJson(data))
          .toList();

      return subfuncionalidades;
    } else {
      throw SubFuncionalitiesException("Funcionalidades não encontrada !");
    }
  }

  Future<bool> create(FuncionalitieModel funcionalitie,
      SubFuncionalitiesModel subFuncionalitie) async {
    Response response = await api.post(
        '/itensfuncionalidades/' + funcionalitie.id.toString(),
        subFuncionalitie.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw SubFuncionalitiesException("Funcionalidade não foi cadastrada !");
    }
  }

  Future<bool> update(SubFuncionalitiesModel subFuncionalitie) async {
    Response response = await api.put(
        '/itensfuncionalidades/' + subFuncionalitie.id.toString(),
        subFuncionalitie.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw SubFuncionalitiesException("Funcionalidade não foi atualizada !");
    }
  }

  Future<bool> delete(SubFuncionalitiesModel funcionalitie) async {
    Response response = await api.delete(
      '/itensfuncionalidades/' + funcionalitie.id.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw SubFuncionalitiesException(error);
    }
  }
}
