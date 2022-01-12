import 'dart:convert';

import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/shared/exceptions/departament_exception.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:http/http.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class DepartamentRepository {
  ApiService api;

  DepartamentRepository({
    required this.api,
  });

  Future<List<DepartamentModel>> fetchAll() async {
    Response response = await api.get('/departamentos');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<DepartamentModel> departament = data.first
          .map<DepartamentModel>((data) => DepartamentModel.fromJson(data))
          .toList();
      return departament;
    } else {
      throw DepartamentException("Não foi possível encontrar departamentos !");
    }
  }

  Future<List<SubFuncionalitiesModel>> fetchSubFuncionalities(
      DepartamentModel departament) async {
    Response response = await api.get(
        '/departamentos/itensfuncionalidades/' + departament.id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalitiesModel> subFuncionalities = data.first
          .map<SubFuncionalitiesModel>(
              (data) => SubFuncionalitiesModel.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      throw FuncionalitiesException(
          "Não foi possivel encontrar itens de funcionalidades relacionadas ao departamentos !");
    }
  }

  Future<bool> updateDepartmentSubFuncionalities(DepartamentModel departament,
      List<SubFuncionalitiesModel> subFuncionalities) async {
    List<Map<String, dynamic>> dataSend = subFuncionalities
        .map((subFuncionalitie) => subFuncionalitie.toJson())
        .toList();

    Response response = await api.put(
        '/departamentos/itensfuncionalidades/' + departament.id.toString(),
        dataSend);

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      return throw DepartamentException(
          "Funcionalidades do departamento foram atualizadas !");
    }
  }

  Future<bool> create(DepartamentModel departament) async {
    Response response = await api.post('/departamentos', departament.toJson());
    print(departament.toJson());
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw DepartamentException(error);
    }
  }

  Future<bool> delete(DepartamentModel departament) async {
    Response response = await api.delete(
      '/departamentos/' + departament.id.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw DepartamentException(error);
    }
  }

  Future<bool> update(DepartamentModel departament) async {
    Response response = await api.put(
        '/departamentos/' + departament.id.toString(), departament.toJson());

    print(departament.toJson());
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw DepartamentException("Departamento não foi atualizado!");
    }
  }
}
