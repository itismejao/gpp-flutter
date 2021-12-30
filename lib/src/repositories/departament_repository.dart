import 'dart:convert';

import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/shared/exceptions/departament_exception.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:http/http.dart';

import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class DepartamentRepository {
  ApiService api;

  DepartamentRepository({
    required this.api,
  });

  Future<List<DepartamentModel>> fetchDepartament() async {
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

  Future<List<SubFuncionalities>> fetchSubFuncionalities(
      DepartamentModel departament) async {
    Response response =
        await api.get('/departamentos/itensfuncionalidades/' + departament.id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalities> subFuncionalities = data.first
          .map<SubFuncionalities>((data) => SubFuncionalities.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      throw FuncionalitiesException(
          "Não foi possivel encontrar itens de funcionalidades relacionadas ao departamentos !");
    }
  }

  Future<bool> updateDepartmentSubFuncionalities(DepartamentModel departament,
      List<SubFuncionalities> subFuncionalities) async {
    List<Map<String, dynamic>> dataSend = subFuncionalities
        .map((subFuncionalitie) => subFuncionalitie.toJson())
        .toList();

    Response response = await api.put(
        '/departamentos/itensfuncionalidades/' + departament.id, dataSend);

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      return throw DepartamentException(
          "Funcionalidades do departamento foram atualizadas !");
    }
  }
}
