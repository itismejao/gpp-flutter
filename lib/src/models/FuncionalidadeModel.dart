import 'package:gpp/src/models/subfuncionalities_model.dart';

class FuncionalidadeModel {
  int? idFuncionalidade;
  String? nome;
  String? icone;
  bool? situacao;
  bool? isExpanded = false;
  List<SubFuncionalidadeModel>? subFuncionalidades;
  FuncionalidadeModel({
    this.idFuncionalidade,
    this.nome,
    this.icone,
    this.situacao,
    this.isExpanded,
    this.subFuncionalidades,
  });

  factory FuncionalidadeModel.fromJson(Map<String, dynamic> json) {
    return FuncionalidadeModel(
        idFuncionalidade: json['id_funcionalidade'],
        nome: json['nome'],
        icone: json['icone'],
        situacao: json['situacao'],
        subFuncionalidades: json['sub_funcionalidades'] != null
            ? json['sub_funcionalidades'].map<SubFuncionalidadeModel>((data) {
                return SubFuncionalidadeModel.fromJson(data);
              }).toList()
            : null,
        isExpanded: false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_funcionalidade'] = idFuncionalidade;
    data['nome'] = nome;
    data['icone'] = icone;
    data['situacao'] = situacao;
    data['sub_funcionalidades'] != null
        ? subFuncionalidades!.map((v) => v.toJson()).toList()
        : null;

    return data;
  }
}
