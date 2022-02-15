import 'package:gpp/src/models/fornecedor_model.dart';

class ProdutoModel {
  int? idProduto;
  String? resumida;
  FornecedorModel? fornecedor;

  ProdutoModel({this.idProduto, this.resumida, this.fornecedor});

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
        idProduto: json['id_produto'],
        resumida: json['resumida'],
        fornecedor: json['fornecedor'] != null
            ? new FornecedorModel.fromJson(json['fornecedor'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_produto'] = this.idProduto;
    data['resumida'] = this.resumida;
    if (this.fornecedor != null) {
      data['fornecedor'] = this.fornecedor!.toJson();
    }
    return data;
  }
}
