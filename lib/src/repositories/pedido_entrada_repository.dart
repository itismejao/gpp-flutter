import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/pedido_entrada_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PedidoEntradaRepository {
  late ApiService api;

  PedidoEntradaRepository() {
    api = ApiService();
  }

  Future<List> buscarPedidosEntrada(int pagina, {int? idPedido, DateTime? dataInicio, DateTime? dataFim, int? situacao}) async {
    Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'idPedido': idPedido != null ? idPedido.toString() : '',
      'dataInicio': dataInicio != null ? dataInicio.toString() : '',
      'dataFim': dataFim != null ? dataFim.toString() : '',
      'situacao': situacao != null ? situacao.toString() : ''
    };

    Response response = await api.get('/pedidos-entrada', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PedidoEntradaModel> pedidosEntrada =
          data['pedidos'].map<PedidoEntradaModel>((data) => PedidoEntradaModel.fromJson(data)).toList();

      PaginaModel pagina = PaginaModel.fromJson(data['pagina']);
      return [pedidosEntrada, pagina];
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<PedidoEntradaModel> buscarPedidoEntrada(int id) async {
    Response response = await api.get('/pedidos-entrada/${id.toString()}');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      PedidoEntradaModel pedidoEntrada = PedidoEntradaModel.fromJson(data);
      return pedidoEntrada;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<PedidoEntradaModel> criar(PedidoEntradaModel pedidoEntrada) async {
    print(jsonEncode(pedidoEntrada.toJson()));
    Response response = await api.post('/pedidos-entrada', pedidoEntrada.toJson());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      PedidoEntradaModel pedidoEntrada = PedidoEntradaModel.fromJson(data);

      return pedidoEntrada;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}
