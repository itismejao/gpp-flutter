import 'dart:convert';

import 'package:gpp/src/models/entrada/movimento_entrada_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class MovimentoEntradaRepository {
  ApiService api;

  MovimentoEntradaRepository({required this.api});

  Future<List<MovimentoEntradaModel>> buscarTodos(String? id_filial,
      {String? id_funcionario}) async {
    Map<String, String> queryParameters = {
      'id_filial': id_filial == null ? '' : id_filial,
      'id_funcionario': id_funcionario == null ? '' : id_funcionario
    };

    Response response =
        await api.get('/movimento-entrada', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<MovimentoEntradaModel> movimentoEntrada = data
          .map<MovimentoEntradaModel>(
              (data) => MovimentoEntradaModel.fromJson(data))
          .toList();
      return movimentoEntrada;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}
