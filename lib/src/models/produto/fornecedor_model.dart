import 'package:gpp/src/models/cliente_model.dart';

class FornecedorModel {
  int? idFornecedor;
  ClienteModel? cliente;

  FornecedorModel({this.idFornecedor, this.cliente});

  FornecedorModel.fromJson(Map<String, dynamic> json) {
    idFornecedor = json['id_fornecedor'];
    cliente = json['cliente'] != null
        ? new ClienteModel.fromJson(json['cliente'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_fornecedor'] = this.idFornecedor;
    if (this.cliente != null) {
      data['cliente'] = this.cliente!.toJson();
    }
    return data;
  }
}
