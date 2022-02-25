class PrateleiraEnderecamentoModel {
  int? id_prateleira;
  String? desc_prateleira;
  int? id_estante;

  PrateleiraEnderecamentoModel({
    this.id_prateleira,
    this.desc_prateleira,
    this.id_estante});

    factory PrateleiraEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return PrateleiraEnderecamentoModel(
      id_prateleira: json['id_prateleira'],
      desc_prateleira: json['desc_prateleira'],
      id_estante: json['id_estante']);
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_prateleira'] = this.id_prateleira;
    data['desc_prateleira'] = this.desc_prateleira;
    data['id_estante'] = this.id_estante;
    
    return data;
    }
}