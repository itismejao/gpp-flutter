import 'package:gpp/src/models/PecaModel.dart';

class ProdutoPecaModel {
  int idProdutoPeca;
  int quantidadePorProduto;
  PecaModel peca;

  ProdutoPecaModel({
    required this.idProdutoPeca,
    required this.quantidadePorProduto,
    required this.peca,
  });

  factory ProdutoPecaModel.fromJson(Map<String, dynamic> json) {
    return ProdutoPecaModel(
        idProdutoPeca: json['id_produto_peca'],
        quantidadePorProduto: json['quantidade_por_produto'],
        peca: PecaModel.fromJson(json['peca']));
  }
}
