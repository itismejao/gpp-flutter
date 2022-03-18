import 'package:gpp/src/models/ProdutoPecaModel.dart';
import 'package:gpp/src/models/pecas_model/fornecedor_pecas_model.dart';
import 'package:gpp/src/models/pecas_model/PecaModel.dart';

class ProdutoModel {
  int? id_produto;
  String? situacao;
  String? cod_barra;
  String? resumida;
  String? marca;
  String? data_cadastro;
  int? id_fornecedor;

  List<ProdutoPecaModel>? produtoPecas;

  List<PecasFornecedorModel>? fornecedor;

  ProdutoModel(
      {this.id_produto,
      this.situacao,
      this.cod_barra,
      this.resumida,
      this.marca,
      this.data_cadastro,
      this.id_fornecedor,
      this.fornecedor,
      this.produtoPecas});

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
        id_produto: json['id_produto'],
        // situacao: json['situacao'],
        // cod_barra: json['cod_barra'],
        resumida: json['resumida'],
        // marca: json['marca'],
        // data_cadastro: json['data_cadastro'],
        id_fornecedor: json['id_fornecedor'],
        // fornecedor: json['fornecedor'] == null ? null : FornecedorPecasModel.fromJson(json['fornecedor']),
        fornecedor: json['fornecedor'] != null
            ? json['fornecedor'].map<PecasFornecedorModel>((data) {
                return PecasFornecedorModel.fromJson(data);
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
