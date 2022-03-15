import 'package:flutter/material.dart';

class FilialModel {
  int? id_filial;
  String? sigla;

  FilialModel({
    this.id_filial,
    this.sigla,
  });

  factory FilialModel.fromJson(Map<String, dynamic> json) {
    return FilialModel(
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
