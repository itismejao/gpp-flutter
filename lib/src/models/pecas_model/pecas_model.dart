import 'package:gpp/src/models/pecas_model/produto_peca_model.dart';
import 'package:gpp/src/models/produto_model.dart';

class PecasModel {
  // Teste
  // int? id_produto;
  // int? id_fornecedor;
  // Fim teste
  int? id_peca_especie;
  String? numero;
  String? codigo_fabrica;
  int? unidade;
  String? descricao;
  double? altura;
  double? largura;
  double? profundidade;
  int? unidade_medida;
  double? volumes;
  int? active;
  double? custo;
  int? classificacao_custo;
  int? tipo_classificacao_custo;
  int? id_peca_material_fabricacao;
  int? id_peca_cor;
  DateTime? created_at;
  DateTime? updated_at;
  String? material_fabricacao;
  String? especie;

  // List<ProdutoPecaModel>? produto_peca;

  PecasModel({
    this.id_peca_especie,
    this.numero,
    this.codigo_fabrica,
    this.unidade,
    this.descricao,
    this.altura,
    this.largura,
    this.profundidade,
    this.unidade_medida,
    this.volumes,
    this.active,
    this.custo,
    this.classificacao_custo,
    this.tipo_classificacao_custo,
    this.id_peca_material_fabricacao,
    this.id_peca_cor,
    this.created_at,
    this.updated_at,
    this.material_fabricacao,
    this.especie,
  });

  factory PecasModel.fromJson(Map<String, dynamic> json) {
    return PecasModel(
      id_peca_especie: json['id_peca_especie'],
      numero: json['numero'],
      codigo_fabrica: json['codigo_fabrica'],
      unidade: json['unidade'],
      descricao: json['descricao'],
      altura: json['altura'],
      largura: json['largura'],
      profundidade: json['profundidade'],
      unidade_medida: json['unidade_medida'],
      volumes: json['volumes'],
      active: json['active'],
      custo: json['custo'],
      classificacao_custo: json['classificacao_custo'],
      tipo_classificacao_custo: json['tipo_classificacao_custo'],
      id_peca_material_fabricacao: json['id_peca_material_fabricacao'],
      id_peca_cor: json['id_peca_cor'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      material_fabricacao: json['material_fabricacao'],
      especie: json['especie'],
      // produto_peca: json['produto_peca'] != null
      //     ? json['produto_peca'].map<ProdutoPecaModel>((data) {
      //         return ProdutoPecaModel.fromJson(data);
      //       }).toList()
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_peca_especie'] = this.id_peca_especie;
    data['numero'] = this.numero;
    data['codigo_fabrica'] = this.codigo_fabrica;
    data['unidade'] = this.unidade;
    data['descricao'] = this.descricao;
    data['altura'] = this.altura;
    data['largura'] = this.largura;
    data['profundidade'] = this.profundidade;
    data['unidade_medida'] = this.unidade_medida;
    data['volumes'] = this.volumes;
    data['active'] = this.active;
    data['custo'] = this.custo;
    data['classificacao_custo'] = this.classificacao_custo;
    data['tipo_classificacao_custo'] = this.tipo_classificacao_custo;
    data['id_peca_material_fabricacao'] = this.id_peca_material_fabricacao;
    data['id_peca_cor'] = this.id_peca_cor;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['material_fabricacao'] = this.material_fabricacao;
    data['especie'] = this.especie;

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
