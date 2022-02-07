import 'package:gpp/src/models/pecas_model/produto_peca_model.dart';

class PecasModel {
  int? id_peca;
  int? id_especie;
  int? numero;
  int? codigo_fabrica;
  double? custo;
  int? unidade;
  String? descricao;
  double? largura;
  double? altura;
  double? profundidade;
  int? unidade_medida;
  String? classificacao_custo;
  String? tipo_classificacao_custo;
  double? volume;
  int? status;

  List<ProdutoPecaModel>? produtoPecaModel;

  PecasModel({
    this.id_peca,
    this.id_especie,
    this.numero,
    this.codigo_fabrica,
    this.custo,
    this.unidade,
    this.descricao,
    this.largura,
    this.altura,
    this.profundidade,
    this.unidade_medida,
    this.classificacao_custo,
    this.tipo_classificacao_custo,
    this.volume,
    this.status,
  });

  // factory PecasModel.fromJson(Map<String, dynamic> json) {

  // }
}
