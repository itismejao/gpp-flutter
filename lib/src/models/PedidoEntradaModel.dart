import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/ItemPedidoEntradaModel.dart';
import 'package:gpp/src/models/funcionario_model.dart';

class PedidoEntradaModel {
  int? idPedidoEntrada;
  AstecaModel? asteca;
  DateTime? dataEmissao;
  int? situacao;
  double? valorTotal = 0.0;
  //Falta objeto do movimento de entrada

  List<ItemPedidoEntradaModel>? itensPedidoEntrada;
  FuncionarioModel? funcionario;

  PedidoEntradaModel(
      {this.idPedidoEntrada,
      this.asteca,
      this.dataEmissao,
      this.situacao,
      this.valorTotal,
      this.funcionario,
      this.itensPedidoEntrada});

  factory PedidoEntradaModel.fromJson(Map<String, dynamic> json) {
    return PedidoEntradaModel(
      idPedidoEntrada: json['id_pedido_entrada'],
      dataEmissao: DateTime.parse(json['data_emissao']),
      situacao: json['situacao'],
      valorTotal: json['valor_total'],
      funcionario: json['funcionario'] != null
          ? FuncionarioModel.fromJson((json['funcionario'] as List).first)
          : null,
      asteca:
          json['asteca'] != null ? AstecaModel.fromJson(json['asteca']) : null,
      itensPedidoEntrada: json['items_pedido_entrada'] != null
          ? json['items_pedido_entrada'].map<ItemPedidoEntradaModel>((data) {
              return ItemPedidoEntradaModel.fromJson(data);
            }).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pedido_entrada'] = idPedidoEntrada;
    data['situacao'] = situacao;
    data['valor_total'] = valorTotal;
    //data['data_emissao'] =
    //     dataEmissao != null ? dataEmissao!.toIso8601String() : null;
    data['asteca'] = asteca != null ? asteca!.toJson() : null;
    data['funcionario'] = funcionario != null ? funcionario!.toJson() : null;
    data['itens_pedido_entrada'] = itensPedidoEntrada != null
        ? itensPedidoEntrada!.map((e) => e.toJson()).toList()
        : null;
    return data;
  }
}
