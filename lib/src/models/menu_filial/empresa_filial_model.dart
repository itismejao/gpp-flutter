import 'package:flutter/material.dart';
import 'package:gpp/src/models/menu_filial/filial_model.dart';

class EmpresaFilialModel {
  int? id_empresa;
  int? id_filial;

  FilialModel? filial;

  EmpresaFilialModel({
    this.id_empresa,
    this.id_filial,
    this.filial,
  });

  factory EmpresaFilialModel.fromJson(Map<String, dynamic> json) {
    print('aqui 2');
    print(json);
    return EmpresaFilialModel(
      id_empresa: json['id_empresa'],
      id_filial: json['id_filial'],
      filial: json['filial'] != null ? FilialModel.fromJson(json['filial']) : null,
    );
  }
}
