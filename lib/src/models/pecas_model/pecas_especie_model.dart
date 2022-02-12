import 'package:flutter/material.dart';

class PecasEspecieModel {
  // int? id_peca_especie;
  String? especie;
  int? active;
  int? id_peca_linha;

  PecasEspecieModel({
    // this.id_peca_especie,
    this.especie,
    // this.active,
    this.id_peca_linha,
  });

  factory PecasEspecieModel.fromJson(Map<String, dynamic> json) {
    return PecasEspecieModel(
      // id_peca_especie: json['id_peca_especie'],
      especie: json['especie'],
      // active: json['active'],
      id_peca_linha: json['id_peca_linha'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    // data['id_peca_especie'] = this.id_peca_especie;
    data['especie'] = this.especie;
    // data['active'] = this.active;
    data['id_peca_linha'] = this.id_peca_linha;

    return data;
  }
}
