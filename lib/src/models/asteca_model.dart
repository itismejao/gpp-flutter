class AstecaModel {
  int? id;
  String? name;
  int? salebranch;
  int? invoice;
  String? series;
  String? opendate;
  String? defect;
  String? note;
  String? signal;

  AstecaModel(
      {this.id,
      this.name,
      this.salebranch,
      this.invoice,
      this.series,
      this.opendate,
      this.defect,
      this.note,
      this.signal});

  factory AstecaModel.fromJson(Map<String, dynamic> json) {
    return AstecaModel(
        id: int.parse(json['id']),
        name: json['name'],
        salebranch: int.parse(json['salebranch']),
        invoice: int.parse(json['invoice']),
        series: json['series'],
        opendate: json['opendate'],
        defect: json['defect'],
        note: json['note'],
        signal: json['signal']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['salebranch'] = salebranch;
    data['invoice'] = invoice;
    data['series'] = series;
    data['opendate'] = opendate;
    data['defect'] = defect;
    data['note'] = note;
    data['signal'] = signal;
    return data;
  }
}
