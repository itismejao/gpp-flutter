import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/models/produto/produto_model.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class ProdutoRepository {
  late ApiService api;

  ProdutoRepository() {
    api = ApiService();
  }

  Future<List> buscarProdutos(int pagina, {String? pesquisar}) async {
    Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'pesquisar': pesquisar ?? '',
    };

    Response response =
        await api.get('/produtos', queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<ProdutoModel> produtos = data['dados']
          .map<ProdutoModel>((data) => ProdutoModel.fromJson(data))
          .toList();

      PaginaModel pagina = PaginaModel.fromJson(data['pagina']);
      return [produtos, pagina];
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<ProdutoModel> buscarProduto(int id) async {
    Response response = await api.get('/produtos/${id}');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return ProdutoModel.fromJson(data);
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

//remover depois
  Future<ProdutoModel> buscar(String id) async {
    Response response = await api.get('/produtos/${id}');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return ProdutoModel.fromJson(data);
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<void> inserirProdutoPecas(int id, ProdutoModel produto) async {
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

  Future<List<ProdutoPecaModel>> buscarProdutoPecas(int idProduto) async {
    Response response = await api.get('/produtos/${idProduto}/pecas');

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

  Future<bool> deletarProdutoPeca(int idProduto, int idPeca) async {
    Response response =
        await api.delete('/produtos/${idProduto}/pecas/${idPeca}');

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}
