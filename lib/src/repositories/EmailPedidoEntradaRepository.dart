import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/PedidoEntradaModel.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class EmailPedidoEntradaRepository {
  ApiService api = gppApi;

  Future<bool> criar(PedidoEntradaModel pedidoEntrada) async {
    Response response =
        await api.post('/email-pedido-entrada', pedidoEntrada.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}
