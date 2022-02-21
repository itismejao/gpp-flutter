import 'package:gpp/src/models/PecaEstoqueModel.dart';

class PecaModel {
  int idPeca;
  String descricao;
  double? custo;
  List<PecaEstoqueModel> estoque;

  PecaModel({
    required this.idPeca,
    required this.descricao,
    required this.custo,
    required this.estoque,
  });

  factory PecaModel.fromJson(Map<String, dynamic> json) {
    return PecaModel(
        idPeca: json['id_peca'],
        descricao: json['descricao'],
        custo: json['custo'] != null ? json['custo'] : null,
        estoque: (json['estoque'] as List).isNotEmpty
            ? json['estoque'].map<PecaEstoqueModel>((json) {
                return PecaEstoqueModel.fromJson(json);
              }).toList()
            : []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_peca'] = idPeca;
    data['descricao'] = descricao;
    data['custo'] = custo;
    return data;
  }
}
