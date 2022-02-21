class Cliente {
  int? id_cliente;
  String? nome;

  Cliente({this.id_cliente, this.nome});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id_cliente: json['id_cliente'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cliente'] = this.id_cliente;
    data['nome'] = this.nome;
    return data;
  }
}
