import 'dart:convert';

import 'package:gpp/src/models/PecaEstoqueModel.dart';
import 'package:gpp/src/models/pecas_model/peca_model.dart';
import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/models/produto/produto_model.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';
import 'package:universal_html/html.dart';

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

      List<ProdutoModel> produto = data.map<ProdutoModel>((data) => ProdutoModel.fromJson(data)).toList();

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

    Response response = await api.post('/produtos/${id}/pecas', produto.toJson());

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

      List<ProdutoPecaModel> produtoPecas = data.map<ProdutoPecaModel>((data) => ProdutoPecaModel.fromJson(data)).toList();
      List<ProdutoPecaModel> novaLista = await tratarMeuEstoque(produtoPecas);
      return novaLista;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }
}

tratarMeuEstoque(List<ProdutoPecaModel>? p) async {
  List<ProdutoPecaModel> novaLista = [];

  p!.forEach((pp) {
    if (pp.peca!.estoque!.isEmpty) {
      pp.peca!.estoqueUnico = null;
      novaLista.add(pp);
    } else {
      pp.peca?.estoque!.forEach((element) {
        PecasModel peca;
        peca = new PecasModel(
            active: pp.peca!.active,
            altura: pp.peca!.altura,
            classificacao_custo: pp.peca!.classificacao_custo,
            codigo_fabrica: pp.peca!.codigo_fabrica,
            cor: pp.peca!.cor,
            custo: pp.peca!.custo,
            descricao: pp.peca!.descricao,
            especie: pp.peca!.especie,
            estoque: null,
            estoqueUnico: PecaEstoqueModel(
                idPecaEstoque: element.idPecaEstoque,
                saldoDisponivel: element.saldoDisponivel,
                saldoReservado: element.saldoReservado,
                endereco: element.endereco),
            id_peca: pp.peca!.id_peca,
            id_peca_cor: pp.peca!.id_peca_cor,
            id_peca_especie: pp.peca!.id_peca_especie,
            id_peca_material_fabricacao: pp.peca!.id_peca_material_fabricacao,
            largura: pp.peca!.largura,
            material_fabricacao: pp.peca!.material_fabricacao,
            numero: pp.peca!.numero,
            pecasCorModel: pp.peca!.pecasCorModel,
            pecasEspecieModel: pp.peca!.pecasEspecieModel,
            pecasMaterialModel: pp.peca!.pecasMaterialModel,
            produtoPeca: pp.peca!.produtoPeca,
            produto_peca: pp.peca!.produto_peca,
            profundidade: pp.peca!.profundidade,
            tipo_classificacao_custo: pp.peca!.tipo_classificacao_custo,
            unidade: pp.peca!.unidade,
            unidade_medida: pp.peca!.unidade_medida,
            volumes: pp.peca!.volumes);
        novaLista.add(ProdutoPecaModel(
            idProdutoPeca: pp.idProdutoPeca,
            id_produto: pp.idProdutoPeca,
            peca: peca,
            quantidadePorProduto: pp.quantidadePorProduto));
        //print("meu saldo: ${produtoPeca.peca!.id_peca} ${produtoPeca.peca!.estoqueUnico!.saldoDisponivel}");
      });
    }
  });
  return novaLista;
}
