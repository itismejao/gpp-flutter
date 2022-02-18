import 'package:gpp/src/models/ItemPedidoSaidaModel.dart';
import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/funcionario_model.dart';

class PedidoSaidaModel {
  int? idPedidoSaida;
  int? cpfCnpj;
  int? filial_venda;
  int? numDocFiscal;
  String? serieDocFiscal;
  DateTime? dataEmissao;
  int? situacao;
  double valorTotal = 0.0;
  AstecaModel? asteca;
  FuncionarioModel? funcionario;
  List<ItemPedidoSaidaModel>? itemPedidoSaida;
  PedidoSaidaModel({
    this.idPedidoSaida,
    this.cpfCnpj,
    this.filial_venda,
    this.numDocFiscal,
    this.serieDocFiscal,
    this.dataEmissao,
    this.situacao,
    required this.valorTotal,
    this.asteca,
    this.funcionario,
    required this.itemPedidoSaida,
  });
}
