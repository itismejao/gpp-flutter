import 'package:gpp/src/models/cliente_model.dart';
import 'package:gpp/src/models/funcionario_model.dart';

class ClienteFuncModel {
  int? idClienteFunc;
  FuncionarioModel? funcionario;
  ClienteModel? cliente;

  ClienteFuncModel({this.idClienteFunc, this.funcionario, this.cliente});

  factory ClienteFuncModel.fromJson(Map<String, dynamic> json) {
    return ClienteFuncModel(
        idClienteFunc: json['id_cliente_func'] != null ? json['funcionario'] : null,
        funcionario: json['funcionario'] != null ? FuncionarioModel.fromJson(json['funcionario']) : null,
        cliente: json['cliente'] != null ? ClienteModel.fromJson(json['cliente']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cliente_func'] = this.idClienteFunc;
    data['funcionario'] = this.funcionario != null ? this.funcionario!.toJson() : null;
    data['cliente'] = this.cliente != null ? this.cliente!.toJson() : null;
    return data;
  }
}
