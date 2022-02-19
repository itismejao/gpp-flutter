class PecaModel {
  int? idPeca;
  String? descricao;
  double custo;
  PecaModel({
    this.idPeca,
    this.descricao,
    required this.custo,
  });

  factory PecaModel.fromJson(Map<String, dynamic> json) {
    return PecaModel(idPeca: json['id_peca'], custo: json['custo']);
  }
}
