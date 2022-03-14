import 'package:flutter/material.dart';

class MenuFilialModel {
  int? id_filial;
  String? sigla;

  MenuFilialModel({
    this.id_filial,
    this.sigla,
  });

  factory MenuFilialModel.fromJson(Map<String, dynamic> json) {
    return MenuFilialModel(
      id_filial: json['id_filial'],
      sigla: json['sigla'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id_filial'] = this.id_filial;
    data['sigla'] = this.sigla;

    return data;
  }
}
