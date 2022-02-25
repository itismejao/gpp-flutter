class ClienteModel {
  int? idCliente;
  String? nome;

  ClienteModel({this.idCliente, this.nome});

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['id_cliente'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cliente'] = this.idCliente;
    data['nome'] = this.nome;
    return data;
  }
}
