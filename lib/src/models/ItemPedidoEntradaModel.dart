import 'package:gpp/src/models/pecas_model/peca_model.dart';

class ItemPedidoEntradaModel {
  int? idItemPedidoEntrada;
  int? quantidade;
  double? custo;
  PecasModel? peca;
  int? quantidade_recebida;

  ItemPedidoEntradaModel({
    this.idItemPedidoEntrada,
    this.quantidade,
    this.custo,
    this.peca,
  });

  factory ItemPedidoEntradaModel.fromJson(Map<String, dynamic> json) {
    return ItemPedidoEntradaModel(
        idItemPedidoEntrada: json['id_item_pedido_entrada'],
        quantidade: json['quantidade'],
        custo: json['custo'],
        peca: PecasModel.fromJson(json['peca']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_item_pedido_entrada'] = idItemPedidoEntrada;
    data['quantidade'] = quantidade;
    data['custo'] = custo;
    data['peca'] = peca!.toJson();
    return data;
  }
}
