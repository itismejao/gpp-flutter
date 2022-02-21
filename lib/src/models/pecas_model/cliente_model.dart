import 'package:flutter/material.dart';

class ClienteModel {
  int? id_cliente;
  String? nome;

  ClienteModel({
    this.id_cliente,
    this.nome,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id_cliente: json['id_cliente'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id_cliente'] = this.id_cliente;
    data['nome'] = this.nome;

    return data;
  }
}
