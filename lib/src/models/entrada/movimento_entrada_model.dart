
import 'package:gpp/src/models/entrada/item_movimento_entrada_model.dart';

class MovimentoEntradaModel{

  int? id_movimento_entrada;
  int? id_funcionario;
  String? num_doc_fiscal;
  String? serie;
  DateTime? data_entrada;
  double? custo_total;
  int? situacao;
  ItemMovimentoEntradaModel? itemMovimentoEntradaModel;

  MovimentoEntradaModel({
    this.id_movimento_entrada,
    this.id_funcionario,
    this.custo_total,
    this.data_entrada,
    this.num_doc_fiscal,
    this.serie,
    this.situacao,
    this.itemMovimentoEntradaModel
  });

  factory MovimentoEntradaModel.fromJson(Map<String, dynamic> json) {
    return MovimentoEntradaModel(
      id_movimento_entrada: json['id_movimento_entrada'],
      id_funcionario: json['id_funcionario'],
      custo_total: json['custo_total'],
      data_entrada: json['data_entrada'],
      num_doc_fiscal: json['num_doc_fiscal'],
      serie: json['serie'],
      situacao: json['situacao'],
      itemMovimentoEntradaModel: json['items_movimento'] == null ? null : ItemMovimentoEntradaModel.fromJson(json['items_movimento'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    //data['id_movimento_entrada'] = this.id_movimento_entrada;
    data['id_funcionario'] = this.id_funcionario;
    data['custo_total'] = this.custo_total;
    data['data_entrada'] = this.data_entrada;
    data['num_doc_fiscal'] = this.num_doc_fiscal;
    data['serie'] = this.serie;
    data['situacao'] = this.situacao;

    return data;
  }



}