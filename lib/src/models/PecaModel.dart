import 'package:gpp/src/models/PecaEstoqueModel.dart';

class PecaModel {
  int idPeca;
  String descricao;
  double custo;
  List<PecaEstoqueModel>? estoque;

  PecaModel({
    required this.idPeca,
    required this.descricao,
    required this.custo,
    this.estoque,
  });

  factory PecaModel.fromJson(Map<String, dynamic> json) {
    return PecaModel(
        idPeca: json['id_peca'],
        descricao: json['descricao'],
        custo: json['custo'] != null ? json['custo'].toDouble() : null,
        estoque: json['estoque'] != null
            ? json['estoque'].map<PecaEstoqueModel>((json) {
                return PecaEstoqueModel.fromJson(json);
              }).toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_peca'] = idPeca;
    data['descricao'] = descricao;
    data['custo'] = custo;
    data['estoque'] = estoque!.map((e) => e.toJson()).toList();
    return data;
  }
}
