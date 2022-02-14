import 'package:flutter/material.dart';

class PecasGrupoModel {
  String? grupo;
  int? situacao;

  PecasGrupoModel({
    this.grupo,
    this.situacao,
  });

  factory PecasGrupoModel.fromJson(Map<String, dynamic> json) {
    return PecasGrupoModel(
      grupo: json['grupo'],
      situacao: json['situacao'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['grupo'] = this.grupo;
    data['situacao'] = this.situacao;

    return data;
  }
}
