import 'dart:convert';

import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:gpp/src/shared/models/funcionalitie_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class FuncionalitiesController {
  Future<List<FuncionalitieModel>> getFuncionalities(int id) async {
    try {
      Response response =
          await gppApi.get('/user/funcionalidades/' + id.toString());

      if (response.statusCode == StatusCode.NOT_FOUND) {
        var error = jsonDecode(response.body)['error'];
        throw FuncionalitiesException(error);
      }

      var data = jsonDecode(response.body);

      List<FuncionalitieModel> funcionalidades = data.first
          .map<FuncionalitieModel>((data) => FuncionalitieModel.fromJson(data))
          .toList();

      return funcionalidades;
    } on FuncionalitiesException {
      rethrow;
    }
  }
}
