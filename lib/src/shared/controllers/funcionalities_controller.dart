import 'dart:convert';

import 'package:gpp/src/shared/models/funcionalitie_model.dart';
import 'package:gpp/src/shared/services/api.dart';

class FuncionalitiesController {
  Future<List<FuncionalitieModel>> getFuncionalities(int id) async {
    var response = await api.get('/user/funcionalidades/' + id.toString());

    List<FuncionalitieModel> funcionalidades = jsonDecode(response.body)
        .map<FuncionalitieModel>((data) => FuncionalitieModel.fromJson(data))
        .toList();

    return funcionalidades;
  }
}
