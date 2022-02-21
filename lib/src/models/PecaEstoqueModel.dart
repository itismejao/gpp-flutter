class PecaEstoqueModel {
  int idPecaEstoque;
  int saldoDisponivel;
  int saldoReservado;

  PecaEstoqueModel({
    required this.idPecaEstoque,
    required this.saldoDisponivel,
    required this.saldoReservado,
  });

  factory PecaEstoqueModel.fromJson(Map<String, dynamic> json) {
    return PecaEstoqueModel(
        idPecaEstoque: json['id_peca_estoque'],
        saldoDisponivel: json['saldo_disponivel'],
        saldoReservado: json['saldo_reservado']);
  }
}
