class BoxEnderecamentoModel {
  int? id_box;
  String? desc_box;
  int? id_prateleira;
  double? altura;
  double? largura;
  double? profundidade;
  int? unidade_medida;
  String? created_at;

  BoxEnderecamentoModel(
      {this.id_box,
      this.desc_box,
      this.id_prateleira,
      this.altura,
      this.largura,
      this.profundidade,
      this.unidade_medida,
      this.created_at});

  factory BoxEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return BoxEnderecamentoModel(
        id_box: json['id_box'],
        desc_box: json['desc_box'],
        id_prateleira: json['id_prateleira'],
        altura: json['altura'],
        largura: json['largura'],
        profundidade: json['profundidade'],
        unidade_medida: json['unidade_medida'],
        created_at: json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_box'] = this.id_box;
    data['desc_box'] = this.desc_box;
    data['id_prateleira'] = this.id_prateleira;
    data['altura'] = this.altura;
    data['largura'] = this.largura;
    data['profundidade'] = this.profundidade;
    data['unidade_medida'] = this.unidade_medida;
    data['created_at'] = this.created_at;

    return data;
  }
}
