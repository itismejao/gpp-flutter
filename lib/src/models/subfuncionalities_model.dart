import 'package:flutter/material.dart';

class SubFuncionalidadeModel {
  int? idSubFuncionalidade;
  String? nome;

  String? rota;
  bool? situacao;

  Color? colorButton;
  BoxDecoration? boxDecoration;

  SubFuncionalidadeModel({
    this.idSubFuncionalidade,
    this.nome,
    this.rota,
    this.situacao,
    this.colorButton,
    this.boxDecoration,
  });
  // Border? border =
  //     Border(left: BorderSide(color: Colors.grey.shade200, width: 2));

  factory SubFuncionalidadeModel.fromJson(Map<String, dynamic> json) {
    return SubFuncionalidadeModel(
      idSubFuncionalidade: json['id_sub_funcionalidade'],
      nome: json['nome'],
      situacao: json['situacao'],
      rota: json['rota'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_sub_funcionalidade'] = idSubFuncionalidade;
    data['name'] = nome;
    data['situacao'] = situacao;

    data['rota'] = rota;

    return data;
  }
}
