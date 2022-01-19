class AstecaModel {
  int? id;
  String? name;
  int? filialvenda;
  int? notafiscal;
  String? serie;
  String? dataabertura;
  String? defeito;
  String? obs;

  AstecaModel(
      {this.id,
      this.name,
      this.filialvenda,
      this.notafiscal,
      this.serie,
      this.dataabertura,
      this.defeito,
      this.obs});

  factory AstecaModel.fromJson(Map<String, dynamic> json) {
    return AstecaModel(
        id: int.parse(json['id']),
        name: json['description'],
        filialvenda: int.parse(json['filialvenda']),
        notafiscal: int.parse(json['notafiscal']),
        serie: json['serie'],
        dataabertura: json['dataabertura'],
        defeito: json['defeito'],
        obs: json['obs']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['filialvenda'] = filialvenda;
    data['notafiscal'] = notafiscal;
    data['serie'] = serie;
    data['dataabertura'] = dataabertura;
    data['defeito'] = defeito;
    data['obs'] = obs;

    return data;
  }
}
