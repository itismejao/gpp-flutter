import 'package:gpp/src/models/pecas_model/produto_peca_model.dart';
import 'package:gpp/src/models/produto_model.dart';

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

  List<ProdutoPecaModel>? produto_peca;

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
    this.produto_peca,
  });

  factory PecasModel.fromJson(Map<String, dynamic> json) {
    return PecasModel(
      id_peca: json['id_peca'],
      id_especie: json['id_especie'],
      numero: json['numero'],
      codigo_fabrica: json['codigo_fabrica'],
      custo: json['custo'],
      unidade: json['unidade'],
      descricao: json['descricao'],
      largura: json['largura'],
      altura: json['altura'],
      profundidade: json['profundidade'],
      unidade_medida: json['unidade_medida'],
      classificacao_custo: json['classificacao_custo'],
      tipo_classificacao_custo: json['tipo_classificacao_custo'],
      volume: json['volume'],
      status: json['status'],
      produto_peca: json['produto_peca'] != null
          ? json['produto_peca'].map<ProdutoPecaModel>((data) {
              return ProdutoPecaModel.fromJson(data);
            }).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_peca'] = this.id_peca;
    data['id_especie'] = this.id_especie;
    data['numero'] = this.numero;
    data['codigo_fabrica'] = this.codigo_fabrica;
    data['custo'] = this.custo;
    data['unidade'] = this.unidade;
    data['descricao'] = this.descricao;
    data['largura'] = this.largura;
    data['altura'] = this.altura;
    data['profundidade'] = this.profundidade;
    data['unidade_medida'] = this.unidade_medida;
    data['classificacao_custo'] = this.classificacao_custo;
    data['tipo_classificacao_custo'] = this.tipo_classificacao_custo;
    data['volume'] = this.volume;
    data['status'] = this.status;

    if (this.produto_peca != null) {
      data['produto_peca'] = this.produto_peca!.map((value) => value.toJson()).toList();
    }

    return data;
  }
}
