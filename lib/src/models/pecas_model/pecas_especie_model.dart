import 'package:flutter/material.dart';

class PecasEspecieModel {
  int? id_peca_especie;
  String? especie;
  int? active;
  int? id_linha;

  PecasEspecieModel({
    this.id_peca_especie,
    this.especie,
    this.active,
    this.id_linha,
  });

  factory PecasEspecieModel.fromJson(Map<String, dynamic> json) {
    return PecasEspecieModel(
      id_peca_especie: json['id_peca_especie'],
      especie: json['especie'],
      active: json['active'],
      id_linha: json['id_linha'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['id_peca_especie'] = this.id_peca_especie;
    data['especie'] = this.especie;
    data['active'] = this.active;
    data['id_linha'] = this.id_linha;

    return data;
  }
}
