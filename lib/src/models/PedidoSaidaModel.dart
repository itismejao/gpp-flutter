import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/ItemPedidoSaidaModel.dart';
import 'package:gpp/src/models/cliente_model.dart';
import 'package:gpp/src/models/funcionario_model.dart';

class PedidoSaidaModel {
  int? idPedidoSaida;
  int? cpfCnpj;
  int? filialVenda;
  int? numDocFiscal;
  String? serieDocFiscal;
  DateTime? dataEmissao;
  int? situacao;
  double? valorTotal = 0.0;
  AstecaModel? asteca;
  FuncionarioModel? funcionario;
  ClienteModel? cliente;
  List<ItemPedidoSaidaModel>? itemsPedidoSaida;
  PedidoSaidaModel({
    this.idPedidoSaida,
    this.cpfCnpj,
    this.filialVenda,
    this.numDocFiscal,
    this.serieDocFiscal,
    this.dataEmissao,
    this.situacao,
    this.valorTotal,
    this.asteca,
    this.funcionario,
    this.cliente,
    this.itemsPedidoSaida,
  });

  factory PedidoSaidaModel.fromJson(Map<String, dynamic> json) {
    return PedidoSaidaModel(
      idPedidoSaida: json['id_pedido_saida'],
      cpfCnpj: json['cpf_cnpj'],
      filialVenda: json['filial_venda'],
      numDocFiscal: json['num_doc_fiscal'],
      serieDocFiscal: json['serie_doc_fiscal'],
      dataEmissao: DateTime.parse(json['data_emissao']),
      situacao: json['situacao'],
      valorTotal: json['valor_total'],
      funcionario: json['funcionario'] != null
          ? FuncionarioModel.fromJson(json['funcionario'].first)
          : null,
      cliente: json['cliente'] != null
          ? ClienteModel.fromJson(json['cliente'])
          : null,
      asteca:
          json['asteca'] != null ? AstecaModel.fromJson(json['asteca']) : null,
      itemsPedidoSaida: json['items_pedido_saida'] != null
          ? json['items_pedido_saida'].map<ItemPedidoSaidaModel>((data) {
              return ItemPedidoSaidaModel.fromJson(data);
            }).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpf_cnpj'] = cpfCnpj;
    data['filial_venda'] = filialVenda;
    data['num_doc_fiscal'] = numDocFiscal;
    data['serie_doc_fiscal'] = serieDocFiscal;
    data['situacao'] = situacao;
    data['valor_total'] = valorTotal;
    data['id_asteca'] = asteca!.idAsteca;
    data['id_funcionario'] = funcionario!.idFuncionario;

    data['items_pedido_saida'] =
        itemsPedidoSaida!.map((e) => e.toJson()).toList();
    return data;
  }
}
