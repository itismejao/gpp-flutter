import 'dart:convert';

import 'package:gpp/src/models/PedidoSaidaMode.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PedidoRepository {
  ApiService api = gppApi;

  Future<List<PedidoSaidaModel>> buscarTodos() async {
    Response response = await api.get('/pedido-saida');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PedidoSaidaModel> pedidos = data
          .map<PedidoSaidaModel>((data) => PedidoSaidaModel.fromJson(data))
          .toList();
      return pedidos;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<PedidoSaidaModel> buscar(int id) async {
    Response response = await api.get('/pedido-saida/${id}');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      PedidoSaidaModel pedido = PedidoSaidaModel.fromJson(data);
      return pedido;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<PedidoSaidaModel> criar(PedidoSaidaModel pedidoSaida) async {
    print(jsonEncode(pedidoSaida.toJson()));

    Response response = await api.post('/pedido-saida', pedidoSaida.toJson());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      PedidoSaidaModel pedido = PedidoSaidaModel.fromJson(data);

      return pedido;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}
