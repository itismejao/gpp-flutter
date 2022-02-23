class PaginaModel {
  int total;
  int atual;
  PaginaModel({
    required this.total,
    required this.atual,
  });

  factory PaginaModel.fromJson(Map<String, dynamic> json) {
    return PaginaModel(total: json['total'], atual: json['atual']);
  }
}
