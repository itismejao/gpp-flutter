import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_material_model.dart';

class PecasGrupoModel {
  int? id_peca_grupo_material;
  String? grupo;
  int? situacao;

  List<PecasMaterialModel>? material;

  PecasGrupoModel({
    this.id_peca_grupo_material,
    this.grupo,
    this.situacao,
    this.material,
  });

  factory PecasGrupoModel.fromJson(Map<String, dynamic> json) {
    return PecasGrupoModel(
      id_peca_grupo_material: json['id_peca_grupo_material'],
      grupo: json['grupo'],
      situacao: json['situacao'],
      material: json['material'] != null
          ? json['material'].map<PecasMaterialModel>((data) {
              return PecasMaterialModel.fromJson(data);
            }).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['grupo'] = this.grupo;
    data['situacao'] = this.situacao;

    return data;
  }
}
