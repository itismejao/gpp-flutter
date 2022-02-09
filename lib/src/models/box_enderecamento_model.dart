class BoxEnderecamentoModel {
  int? id_box;
  String? desc_box;
  int? id_prateleira;

  BoxEnderecamentoModel({
    this.id_box,
    this.desc_box,
    this.id_prateleira});

    factory BoxEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return BoxEnderecamentoModel(
      id_box: json['id_box'],
      desc_box: json['desc_box'],
      id_prateleira: json['id_prateleira']);
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_box'] = this.id_box;
    data['desc_box'] = this.desc_box;
    data['id_prateleira'] = this.id_prateleira;
    
    return data;
    }
}