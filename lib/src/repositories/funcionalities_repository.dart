import 'dart:convert';

import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class FuncionalitiesRepository {
  ApiService api;

  FuncionalitiesRepository({
    required this.api,
  });

  Future<List<FuncionalitieModel>> fetch() async {
    Response response = await api.get('/funcionalidades');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<FuncionalitieModel> funcionalidades = data.first
          .map<FuncionalitieModel>((data) => FuncionalitieModel.fromJson(data))
          .toList();

      return funcionalidades;
    } else {
      throw FuncionalitiesException("Funcionalidades não encontrada !");
    }
  }

  Future<bool> create(FuncionalitieModel funcionalitie) async {
    Response response =
        await api.post('/funcionalidades', funcionalitie.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw FuncionalitiesException("Funcionalidade não foi cadastrada !");
    }
  }

  Future<bool> update(FuncionalitieModel funcionalitie) async {
    Response response = await api.put(
        '/funcionalidades/' + funcionalitie.id.toString(),
        funcionalitie.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw FuncionalitiesException("Funcionalidade não foi atualizada !");
    }
  }

  Future<bool> delete(FuncionalitieModel funcionalitie) async {
    Response response = await api.delete(
      '/funcionalidades/' + funcionalitie.id.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw FuncionalitiesException("Funcionalidade não foi deletada !");
    }
  }
}
