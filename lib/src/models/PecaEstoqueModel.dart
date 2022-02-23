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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_peca_estoque'] = idPecaEstoque;
    data['saldo_disponivel'] = saldoDisponivel;
    data['saldo_reservado'] = saldoReservado;
    return data;
  }
}
