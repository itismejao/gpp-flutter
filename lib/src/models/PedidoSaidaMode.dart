import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/funcionario_model.dart';

class PedidoSaidaModel {
  int? idPedidoSaida;
  int? cpfCnpj;
  int? filial_venda;
  int? numDocFiscal;
  String? serieDocFiscal;
  DateTime? dataEmissao;
  int? situacao;
  double? valorTotal;
  AstecaModel? asteca;
  FuncionarioModel? funcionario;

  PedidoSaidaModel({
    this.idPedidoSaida,
    this.cpfCnpj,
    this.filial_venda,
    this.numDocFiscal,
    this.serieDocFiscal,
    this.dataEmissao,
    this.situacao,
    this.valorTotal,
    this.asteca,
    this.funcionario,
  });
}
