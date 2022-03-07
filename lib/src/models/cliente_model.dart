class ClienteModel {
  int? idCliente;
  String? nome;
  String? cpfCnpj;
  String? email;

  ClienteModel({this.idCliente, this.nome, this.cpfCnpj, this.email});

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['id_cliente'];
    nome = json['nome'];
    cpfCnpj = json['cnpj_cpf'] != null ? json['cnpj_cpf'] : null;
    cpfCnpj = json['e_mail'] != null ? json['e_mail'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cliente'] = this.idCliente;
    data['nome'] = this.nome;
    data['e_mail'] = email;
    return data;
  }
}
