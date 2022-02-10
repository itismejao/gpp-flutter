import 'package:gpp/src/models/pecas_model/produto_peca_model.dart';
import 'package:gpp/src/models/produto_model.dart';

class PecasModel {
  // Teste
  // int? id_produto;
  // int? id_fornecedor;
  // Fim teste
  int? id_peca;
  String? numero;
  String? codigo_fabrica;
  double? custo;
  int? unidade;
  String? descricao;
  double? largura;
  double? altura;
  double? profundidade;
  double? volume;
  int? unidade_medida;
  int? classificacao_custo;
  int? tipo_classificacao_custo;
  int? active;
  int? id_peca_especie;
  int? quantidade;
  int? id_cor;
  int? id_peca_material_fabricacao;
  int? id_produto;

  // List<ProdutoPecaModel>? produto_peca;

  PecasModel({
    this.id_peca,
    this.numero,
    this.codigo_fabrica,
    this.custo,
    this.unidade,
    this.descricao,
    this.largura,
    this.altura,
    this.profundidade,
    this.volume,
    this.unidade_medida,
    this.classificacao_custo,
    this.tipo_classificacao_custo,
    this.active,
    this.id_peca_especie,
    this.quantidade,
    this.id_cor,
    this.id_peca_material_fabricacao,
    this.id_produto,
  });

  factory PecasModel.fromJson(Map<String, dynamic> json) {
    return PecasModel(
      id_peca: json['id_peca'],
      numero: json['numero'],
      codigo_fabrica: json['codigo_fabrica'],
      custo: json['custo'],
      unidade: json['unidade'],
      descricao: json['descricao'],
      largura: json['largura'],
      altura: json['altura'],
      profundidade: json['profundidade'],
      volume: json['volume'],
      unidade_medida: json['unidade_medida'],
      classificacao_custo: json['classificacao_custo'],
      tipo_classificacao_custo: json['tipo_classificacao_custo'],
      active: json['active'],
      id_peca_especie: json['id_peca_especie'],
      quantidade: json['quantidade'],
      id_cor: json['id_cor'],
      id_peca_material_fabricacao: json['id_peca_material_fabricacao'],
      id_produto: json['id_produto'],
      // produto_peca: json['produto_peca'] != null
      //     ? json['produto_peca'].map<ProdutoPecaModel>((data) {
      //         return ProdutoPecaModel.fromJson(data);
      //       }).toList()
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_peca'] = this.id_peca;
    data['numero'] = this.numero;
    data['codigo_fabrica'] = this.codigo_fabrica;
    data['custo'] = this.custo;
    data['unidade'] = this.unidade;
    data['descricao'] = this.descricao;
    data['largura'] = this.largura;
    data['altura'] = this.altura;
    data['profundidade'] = this.profundidade;
    data['volume'] = this.volume;
    data['unidade_medida'] = this.unidade_medida;
    data['classificacao_custo'] = this.classificacao_custo;
    data['tipo_classificacao_custo'] = this.tipo_classificacao_custo;
    data['active'] = this.active;
    data['id_peca_especie'] = this.id_peca_especie;
    data['quantidade'] = this.quantidade;
    data['id_cor'] = this.id_cor;
    data['id_peca_material_fabricacao'] = this.id_peca_material_fabricacao;
    data['id_produto'] = this.id_produto;

    // if (this.produto_peca != null) {
    //   data['produto_peca'] = this.produto_peca!.map((value) => value.toJson()).toList();
    // }

    return data;
  }

  // Map<String, dynamic> toJsonTeste() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();

  //   data['id_produto'] = this.id_produto;
  //   data['id_fornecedor'] = this.id_fornecedor;

  //   return data;
  // }
}
