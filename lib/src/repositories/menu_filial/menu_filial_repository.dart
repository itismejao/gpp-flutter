import 'dart:convert';

import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class FilialRepository {
  ApiService api;

  FilialRepository({
    required this.api,
  });

  Future<List<EmpresaFilialModel>> buscarTodos() async {
    Response response = await api.get('/menu-filiais');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<EmpresaFilialModel> filiais = data
          .map<EmpresaFilialModel>((data) => EmpresaFilialModel.fromJson(data))
          .toList();

      return filiais;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}