class MotivoTrocaPecaModel {
  int? idMotivoTrocaPeca;
  String? nome;
  bool? situacao;
  MotivoTrocaPecaModel({
    this.idMotivoTrocaPeca,
    this.nome,
    this.situacao,
  });

  factory MotivoTrocaPecaModel.fromJson(Map<String, dynamic> json) {
    return MotivoTrocaPecaModel(
        idMotivoTrocaPeca: json['id_motivo_troca_peca'],
        nome: json['nome'],
        situacao: json['situacao']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_motivo_troca_peca'] = idMotivoTrocaPeca;
    data['nome'] = nome;
    data['situacao'] = situacao;
    return data;
  }
}
