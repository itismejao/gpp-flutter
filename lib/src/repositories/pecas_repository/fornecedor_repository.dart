import 'dart:convert';

import 'package:gpp/src/models/produto/fornecedor_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class FornecedorRepository {
  late ApiService api;

  FornecedorRepository() {
    this.api = ApiService();
  }

  Future<FornecedorModel> buscar(String id) async {
    Response response = await api.get('/fornecedor' + '/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return FornecedorModel.fromJson(data);
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}
