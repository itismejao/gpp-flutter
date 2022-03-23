import 'package:gpp/src/models/fornecedor_model.dart';
import 'package:gpp/src/models/produto_peca_model.dart';

import 'package:gpp/src/models/pecas_model/peca_model.dart';

class ProdutoModel {
  int? idProduto;
  String? resumida;
  String? situacao;
  String? cod_barra;
  String? marca;
  String? data_cadastro;

  List<FornecedorModel>? fornecedores;

  List<ProdutoPecaModel>? produtoPecas;

  ProdutoModel(
      {this.idProduto,
      this.situacao,
      this.cod_barra,
      this.resumida,
      this.marca,
      this.data_cadastro,
      this.fornecedores,
      this.produtoPecas});

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
        idProduto: json['id_produto'],
        // situacao: json['situacao'],
        // cod_barra: json['cod_barra'],
        resumida: json['resumida'],
        // marca: json['marca'],
        // data_cadastro: json['data_cadastro'],

        // fornecedor: json['fornecedor'] == null ? null : FornecedorPecasModel.fromJson(json['fornecedor']),
        fornecedores: json['fornecedores'] != null
            ? json['fornecedores'].map<FornecedorModel>((data) {
                return FornecedorModel.fromJson(data);
              }).toList()
            : null,
        produtoPecas: json['produto_peca'] != null
            ? json['produto_peca'].map<PecasModel>((data) {
                return PecasModel.fromJson(data);
              }).toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produto_pecas'] = produtoPecas!.map((e) => e.toJson()).toList();

    return data;
  }
}
