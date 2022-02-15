class FuncionarioModel {
  int? idFuncionario;
  String? nome;

  FuncionarioModel({this.idFuncionario, this.nome});

  FuncionarioModel.fromJson(Map<String, dynamic> json) {
    idFuncionario = json['id_funcionario'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_funcionario'] = this.idFuncionario;
    data['nome'] = this.nome;
    return data;
  }
}
