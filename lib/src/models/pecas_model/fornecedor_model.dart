import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/cliente_model.dart';

class FornecedorModel {
  int? id_fornecedor;
  String? enviado;
  String? cli_forn_principal;

  ClienteModel? cliente;

  FornecedorModel({
    this.id_fornecedor,
    this.enviado,
    this.cli_forn_principal,
    this.cliente,
  });

  factory FornecedorModel.fromJson(Map<String, dynamic> json) {
    return FornecedorModel(
      id_fornecedor: json['id_fornecedor'],
      enviado: json['enviado'],
      cli_forn_principal: json['cli_forn_principal'],
      cliente: json['cliente'] == null ? null : ClienteModel.fromJson(json['cliente']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id_fornecedor'] = this.id_fornecedor;
    data['enviado'] = this.enviado;
    data['cli_forn_principal'] = this.cli_forn_principal;

    return data;
  }
}
