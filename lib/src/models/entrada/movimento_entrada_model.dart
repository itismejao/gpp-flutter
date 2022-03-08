
import 'package:gpp/src/models/entrada/item_movimento_entrada_model.dart';
import 'package:gpp/src/views/entrada/situacao_entrada.dart';
import 'package:gpp/src/views/pedido/PedidoListView.dart';
import 'package:intl/intl.dart';

class MovimentoEntradaModel{

  int? id_movimento_entrada;
  int? id_funcionario;
  String? nome_funcionario;
  int? num_nota_fiscal;
  String? serie;
  DateTime? data_entrada;
  double? custo_total;
  SituacaoEntrada? situacao;
  List<ItemMovimentoEntradaModel>? itemMovimentoEntradaModel;

  MovimentoEntradaModel({
    this.id_movimento_entrada,
    this.id_funcionario,
    this.custo_total,
    this.data_entrada,
    this.num_nota_fiscal,
    this.serie,
    this.situacao,
    this.itemMovimentoEntradaModel,
    this.nome_funcionario
  });

  factory MovimentoEntradaModel.fromJson(Map<String, dynamic> json) {
    return MovimentoEntradaModel(
      id_movimento_entrada: json['id_movimento_entrada'],
      id_funcionario: json['id_funcionario'],
      custo_total: json['custo_total'],
      data_entrada: json['data_entrada'] == null ? null : DateTime.parse(json['data_entrada']),
      num_nota_fiscal: json['num_nota_fiscal'],
      serie: json['serie'],
      situacao: SituacaoEntrada.values[json['situacao']],
      itemMovimentoEntradaModel: json['items_movimento'] == null ? null :
      json['items_movimento'].map<ItemMovimentoEntradaModel>((data){
        return  ItemMovimentoEntradaModel.fromJson(data);
      }).toList()


    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    //data['id_movimento_entrada'] = this.id_movimento_entrada;
    data['id_funcionario'] = this.id_funcionario;
    data['custo_total'] = this.custo_total;
    data['data_entrada'] = this.data_entrada;
    data['num_nota_fiscal'] = this.num_nota_fiscal;
    data['serie'] = this.serie;
    data['situacao'] = this.situacao;

    return data;
  }



}