class ClienteModel {
  int? idCliente;
  String? nome;
  String? cpfCnpj;

  ClienteModel({this.idCliente, this.nome, this.cpfCnpj});

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['id_cliente'];
    nome = json['nome'];
    cpfCnpj = json['cpf_cnpj'] != null ? json['cpf_cnpj'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cliente'] = this.idCliente;
    data['nome'] = this.nome;
    return data;
  }
}
