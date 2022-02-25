class BoxEnderecamentoModel {
  int? id_box;
  String? desc_box;
  int? id_prateleira;
  int? medida;
  String? created_at;

  BoxEnderecamentoModel({this.id_box, this.desc_box, this.id_prateleira, this.medida, this.created_at});

  factory BoxEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return BoxEnderecamentoModel(
        id_box: json['id_box'],
        desc_box: json['desc_box'],
        id_prateleira: json['id_prateleira'],
        medida: json['medida'],
        created_at: json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_box'] = this.id_box;
    data['desc_box'] = this.desc_box;
    data['id_prateleira'] = this.id_prateleira;
    data['medida'] = this.medida;
    data['created_at'] = this.created_at;

    return data;
  }
}
