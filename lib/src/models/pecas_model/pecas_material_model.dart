import 'package:flutter/material.dart';

class PecasMaterialModel {
  int? id_peca_grupo_material;
  String? material;
  String? sigla;
  int? situacao;

  PecasMaterialModel({
    this.id_peca_grupo_material,
    this.material,
    this.sigla,
    this.situacao,
  });

  factory PecasMaterialModel.fromJson(Map<String, dynamic> json) {
    return PecasMaterialModel(
      id_peca_grupo_material: json['id_peca_grupo_material'],
      material: json['material'],
      sigla: json['sigla'],
      situacao: json['situacao'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['id_peca_grupo_material'] = this.id_peca_grupo_material;
    data['material'] = this.material;
    data['sigla'] = this.sigla;
    data['situacao'] = this.situacao;

    return data;
  }
}
