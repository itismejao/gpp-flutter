import 'package:gpp/src/models/pecas_model/pecas_estoque.dart';

class ProdutoPecaModel {
  int? id_produto_peca;
  int? id_produto_sku;
  int? id_peca;
  int? id_material_fabricacao;
  int? id_cor;
  int? quantidade_por_produto;
  int? status;

  List<PecasEstoqueModel>? pecasEstoqueModel;

  ProdutoPecaModel({
    this.id_produto_peca,
    this.id_produto_sku,
    this.id_peca,
    this.id_material_fabricacao,
    this.id_cor,
    this.quantidade_por_produto,
    this.status,
  });
}
