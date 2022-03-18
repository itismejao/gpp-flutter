import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/models/ProdutoPecaModel.dart';
import 'package:gpp/src/models/pecas_model/PecaModel.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecaRepository {
  late ApiService api;

  PecaRepository() {
    api = ApiService();
  }

  Future<List> buscarTodos(int pagina,
      {int? idPedido,
      DateTime? dataInicio,
      DateTime? dataFim,
      int? situacao}) async {
    Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'idPedido': idPedido != null ? idPedido.toString() : '',
      'dataInicio': dataInicio != null ? dataInicio.toString() : '',
      'dataFim': dataFim != null ? dataFim.toString() : '',
      'situacao': situacao != null ? situacao.toString() : ''
    };

    Response response =
        await api.get('/pecas', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<PecasModel> pedidos = data['pecas']
          .map<PecasModel>((data) => PecasModel.fromJson(data))
          .toList();
      //Obtém a pagina
      PaginaModel pagina = PaginaModel.fromJson(data['pagina']);
      return [pedidos, pagina];
    } else {
      var error = json.decode(response.body)['error'];

      throw error;
    }
  }

  // Future<List<ProdutoPecaModel>> buscarTodos(int id) async {
  //   Response response = await api.get('/produtos/${id}/estoques');

  //   if (response.statusCode == StatusCode.OK) {
  //     var data = jsonDecode(response.body);

  //     List<ProdutoPecaModel> produtoPecas = data
  //         .map<ProdutoPecaModel>((data) => ProdutoPecaModel.fromJson(data))
  //         .toList();
  //     return produtoPecas;
  //   } else {
  //     var error = jsonDecode(response.body)['error'];
  //     throw error;
  //   }
  // }

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
