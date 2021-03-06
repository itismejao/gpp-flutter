import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/pedido_saida_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PedidoSaidaRepository {
  late ApiService api;

  PedidoSaidaRepository() {
    api = ApiService();
  }

  Future<List> buscarPedidosSaida(int pagina, {int? idPedido, DateTime? dataInicio, DateTime? dataFim, int? situacao}) async {
    Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'idPedido': idPedido != null ? idPedido.toString() : '',
      'dataInicio': dataInicio != null ? dataInicio.toString() : '',
      'dataFim': dataFim != null ? dataFim.toString() : '',
      'situacao': situacao != null ? situacao.toString() : ''
    };

    Response response = await api.get('/pedidos-saida', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PedidoSaidaModel> pedidos = data['pedidos'].map<PedidoSaidaModel>((data) => PedidoSaidaModel.fromJson(data)).toList();
      //Obtém a pagina
      PaginaModel pagina = PaginaModel.fromJson(data['pagina']);
      return [pedidos, pagina];
    } else {
      var error = json.decode(response.body)['error'];

      throw error;
    }
  }

  Future<PedidoSaidaModel> buscarPedidoSaida(int id) async {
    Response response = await api.get('/pedidos-saida/${id.toString()}');

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

    Response response = await api.post('/pedidos-saida', pedidoSaida.toJson());
    print(response.statusCode);
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
