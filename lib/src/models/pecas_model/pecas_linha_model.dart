import 'package:flutter/material.dart';

class PecasLinhaModel {
  int? id_peca_linha;
  String? linha;
  int? active;

  PecasLinhaModel({
    this.id_peca_linha,
    this.linha,
    this.active,
  });

  factory PecasLinhaModel.fromJson(Map<String, dynamic> json) {
    return PecasLinhaModel(
      id_peca_linha: json['id_peca_linha'],
      linha: json['linha'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['id_peca_linha'] = this.id_peca_linha;
    data['linha'] = this.linha;
    data['active'] = this.active;

    return data;
  }
}
