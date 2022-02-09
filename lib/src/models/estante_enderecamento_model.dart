class EstanteEnderecamentoModel {
  int? id_estante;
  String? desc_estante;
  int? id_corredor;

  EstanteEnderecamentoModel({
    this.id_estante,
    this.desc_estante,
    this.id_corredor});

    factory EstanteEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return EstanteEnderecamentoModel(
      id_estante: json['id_estante'],
      desc_estante: json['desc_estante'],
      id_corredor: json['id_corredor']);
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_estante'] = this.id_estante;
    data['desc_estante'] = this.desc_estante;
    data['id_corredor'] = this.id_corredor;
    
    return data;
    }
}