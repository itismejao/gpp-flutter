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
        quantidade: json['quantidade'],
        valor: json['valor'],
        motivoTrocaPeca:
            MotivoTrocaPecaModel.fromJson(json['motivo_troca_peca']),
        peca: PecaModel.fromJson(json['peca']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantidade'] = quantidade;
    data['valor'] = valor;
    data['id_motivo_troca_peca'] = motivoTrocaPeca!.idMotivoTrocaPeca;
    data['id_peca'] = peca!.idPeca;
    return data;
  }
}
