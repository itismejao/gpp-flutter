import 'dart:convert';

import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/models/produto_model.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class ProdutoRepository {
  late ApiService api;

  ProdutoRepository() {
    api = ApiService();
  }

  Future<List<ProdutoModel>> buscarTodos(String codigo) async {
    int codigo2 = 14634;
    Response response = await api.get('/produtos/' + codigo2.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<ProdutoModel> produto = data
          .map<ProdutoModel>((data) => ProdutoModel.fromJson(data))
          .toList();

      return produto;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<ProdutoModel> buscar(String id) async {
    Response response = await api.get('/produtos' + '/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      // print(ProdutoModel.fromJson(data).id_produto);

      return ProdutoModel.fromJson(data);
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<void> inserirPecasProduto(String id, ProdutoModel produto) async {
    print(json.encode(produto.toJson()));

    Response response =
        await api.post('/produtos/${id}/pecas', produto.toJson());

    if (response.statusCode == StatusCode.OK) {
      //var data = jsonDecode(response.body);

    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<List<ProdutoPecaModel>> buscarProdutoPecas(String id) async {
    Response response = await api.get('/produtos/${id}/pecas');

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
}
