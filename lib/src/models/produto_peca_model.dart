import 'package:gpp/src/models/pecas_model/peca_model.dart';

class ProdutoPecaModel {
  int? idProdutoPeca;
  int? quantidadePorProduto;
  PecasModel? peca;

  ProdutoPecaModel({
    this.idProdutoPeca,
    this.quantidadePorProduto,
    this.peca,
  });

  factory ProdutoPecaModel.fromJson(Map<String, dynamic> json) {
    return ProdutoPecaModel(
        idProdutoPeca: json['id_produto_peca'],
        quantidadePorProduto: json['quantidade_por_produto'],
        peca: PecasModel.fromJson(json['peca']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['quantidade_por_produto'] =
        quantidadePorProduto != null ? quantidadePorProduto : null;
    data['pecas'] = peca != null ? peca!.toJson() : null;

    return data;
  }
}
