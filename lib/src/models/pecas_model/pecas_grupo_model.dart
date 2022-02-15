import 'package:flutter/material.dart';

class PecasGrupoModel {
  int? id_peca_grupo_material;
  String? grupo;
  int? situacao;

  PecasGrupoModel({
    this.id_peca_grupo_material,
    this.grupo,
    this.situacao,
  });

  factory PecasGrupoModel.fromJson(Map<String, dynamic> json) {
    return PecasGrupoModel(
      id_peca_grupo_material: json['id_peca_grupo_material'],
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
