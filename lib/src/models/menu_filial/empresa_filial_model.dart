import 'package:flutter/material.dart';
import 'package:gpp/src/models/menu_filial/menu_filial_model.dart';

class EmpresaFilialModel {
  int? id_empresa;
  int? id_filial;

  MenuFilialModel? filial;

  EmpresaFilialModel({
    this.id_empresa,
    this.id_filial,
    this.filial,
  });

  factory EmpresaFilialModel.fromJson(Map<String, dynamic> json) {
    return EmpresaFilialModel(
      id_empresa: json['id_empresa'],
      id_filial: json['id_filial'],
      filial: json['filial'] != null
          ? json['filial'].map<MenuFilialModel>((data) {
              return MenuFilialModel.fromJson(data);
            }).toList()
          : null,
    );
  }
}
