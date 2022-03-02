import 'package:gpp/src/models/pecas_model/pecas_model.dart';

class PecasEstoqueModel {
  int? id_peca_estoque;
  int? filial;
  int? id_produto_peca;
  int? saldo_disponivel;
  int? saldo_reservado;
  int? quantidade_transferencia;
  int? quantidade_minima;
  PecasModel? pecasModel;

  PecasEstoqueModel({
    this.id_peca_estoque,
    this.filial,
    this.id_produto_peca,
    this.saldo_disponivel,
    this.saldo_reservado,
    this.quantidade_transferencia,
    this.quantidade_minima,
    this.pecasModel
  });

  factory PecasEstoqueModel.fromJson(Map<String, dynamic> json) {
    return PecasEstoqueModel(
      id_peca_estoque: json['id_peca_estoque'],
      filial: json['id_filial'],
      id_produto_peca: json['id_produto_peca'],
      saldo_disponivel: json['saldo_disponivel'],
      saldo_reservado: json['saldo_reservado'],
      quantidade_transferencia: json['quantidade_transferencia'],
      quantidade_minima: json['quantidade_minima'],
      pecasModel: json['peca'] == null ? null : PecasModel.fromJson(json['peca'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_peca_estoque'] = this.id_peca_estoque;
    data['id_filial'] = this.filial;
    data['id_produto_peca'] = this.id_produto_peca;
    data['saldo_disponivel'] = this.saldo_disponivel;
    data['saldo_reservado'] = this.saldo_reservado;
    data['quantidade_transferencia'] = this.quantidade_transferencia;
    data['quantidade_minima'] = this.quantidade_minima;

    return data;
  }
}
