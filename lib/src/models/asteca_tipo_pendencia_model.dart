class AstecaTipoPendenciaModel {
  int? idTipoPendencia;
  String? descricao;
  DateTime? dataCria;
  AstecaTipoPendenciaModel(
      {this.idTipoPendencia, this.descricao, this.dataCria});

  factory AstecaTipoPendenciaModel.fromJson(Map<String, dynamic> json) {
    return AstecaTipoPendenciaModel(
        idTipoPendencia: json['id_tipo_pendencia'],
        descricao: json['descricao'],
        dataCria: DateTime.tryParse(json['data_cria']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tipo_pendencia'] = idTipoPendencia;
    data['descricao'] = descricao;
    return data;
  }
}
