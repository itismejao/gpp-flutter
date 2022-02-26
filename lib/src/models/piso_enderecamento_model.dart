
class PisoEnderecamentoModel {
  int? id_piso;
  String? desc_piso;
  int? id_filial;

  PisoEnderecamentoModel({
    this.id_piso,
    this.desc_piso,
    this.id_filial});

    factory PisoEnderecamentoModel.fromJson(Map<String, dynamic> json) {
    return PisoEnderecamentoModel(
      id_piso: json['id_piso'],
      desc_piso: json['desc_piso'],
      id_filial: json['id_filial']);
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_piso'] = this.id_piso;
    data['desc_piso'] = this.desc_piso;
    data['id_filial'] = this.id_filial;
    
    return data;
    }
}

