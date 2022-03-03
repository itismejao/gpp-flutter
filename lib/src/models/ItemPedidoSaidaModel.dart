import 'package:gpp/src/models/PecaModel.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';

class ItemPedidoSaidaModel {
  int? idItemPedidoSaida;
  int quantidade = 0;
  double valor = 0.0;
  PecaModel? peca;
  MotivoTrocaPecaModel? motivoTrocaPeca;
  ItemPedidoSaidaModel({
    this.idItemPedidoSaida,
    required this.quantidade,
    required this.valor,
    this.peca,
    this.motivoTrocaPeca,
  });

  factory ItemPedidoSaidaModel.fromJson(Map<String, dynamic> json) {
    return ItemPedidoSaidaModel(
        idItemPedidoSaida: json['id_item_pedido_saida'],
        quantidade: json['quantidade'],
        valor: json['valor'],
        motivoTrocaPeca: json['motivo_troca_peca'] != null
            ? MotivoTrocaPecaModel.fromJson(json['motivo_troca_peca'])
            : null,
        peca: json['peca'] != null ? PecaModel.fromJson(json['peca']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantidade'] = quantidade;
    data['valor'] = valor;
    data['motivo_troca_peca'] = motivoTrocaPeca!.toJson();
    data['peca'] = peca!.toJson();
    return data;
  }
}
