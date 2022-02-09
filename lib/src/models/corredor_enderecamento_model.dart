
class CorredorEnderecamentoModel {
  int? id_corredor;
  String? desc_corredor;
  int? id_filial;

  CorredorEnderecamentoModel({
    this.id_corredor,
    this.desc_corredor,
    this.id_filial});

    factory CorredorEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return CorredorEnderecamentoModel(
      id_corredor: json['id_corredor'],
      desc_corredor: json['desc_corredor'],
      id_filial: json['id_filial']);
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_corredor'] = this.id_corredor;
    data['desc_corredor'] = this.desc_corredor;
    data['id_filial'] = this.id_filial;
    
    return data;
    }
}

