import 'package:gpp/src/models/PecaModel.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';

class ItemPedidoEntradaModel {
  int? idItemPedidoEntrada;
  int? quantidade;
  double? valor;
  PecaModel? peca;

  ItemPedidoEntradaModel({
    this.idItemPedidoEntrada,
    this.quantidade,
    this.valor,
    this.peca,
  });

  factory ItemPedidoEntradaModel.fromJson(Map<String, dynamic> json) {
    return ItemPedidoEntradaModel(
        idItemPedidoEntrada: json['id_item_pedido_entrada'],
        quantidade: json['quantidade'],
        valor: json['valor'],
        peca: PecaModel.fromJson(json['peca']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantidade'] = quantidade;
    data['valor'] = valor;
    data['peca'] = peca!.toJson();
    return data;
  }
}
