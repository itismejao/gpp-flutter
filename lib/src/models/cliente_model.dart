class Cliente {
  int? idCliente;
  String? nome;

  Cliente({this.idCliente, this.nome});

  Cliente.fromJson(Map<String, dynamic> json) {
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
