class PecasEstoqueModel {
  int? id_peca_estoque;
  int? filial;
  int? id_produto_peca;
  int? saldo_disponivel;
  int? saldo_reservado;
  int? quantidade_transferencia;
  int? quantidade_minima;

  PecasEstoqueModel({
    this.id_peca_estoque,
    this.filial,
    this.id_produto_peca,
    this.saldo_disponivel,
    this.saldo_reservado,
    this.quantidade_transferencia,
    this.quantidade_minima,
  });
}
