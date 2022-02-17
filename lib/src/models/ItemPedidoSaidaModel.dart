import 'package:gpp/src/controllers/MotivoTrocaPecaController.dart';
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
}
