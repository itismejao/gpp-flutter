import 'package:gpp/src/models/PecaModel.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';

class ItemPedidoEntradaModel {
  int? idItemPedidoEntrada;
  int? quantidade;
  double? custo;
  PecaModel? peca;

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
        peca: PecaModel.fromJson(json['peca']));
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
