import 'dart:convert';

import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/models/ProdutoPecaModel.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecaRepository {
  ApiService api = gppApi;

  Future<List<ProdutoPecaModel>> buscarTodos(int id) async {
    Response response = await api.get('/produtos/${id}/estoques');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<ProdutoPecaModel> produtoPecas = data
          .map<ProdutoPecaModel>((data) => ProdutoPecaModel.fromJson(data))
          .toList();
      return produtoPecas;
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
