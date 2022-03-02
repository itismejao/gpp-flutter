import 'package:gpp/src/models/pecas_model/pecas_estoque_model.dart';

class PecaEnderacamentoModel{
  int id_peca_enderecamento;
  int id_peca_estoque;
  int id_box;
  PecasEstoqueModel? peca_estoque;
  String endereco;
  String? nomeFornecedor;
  String? descPiso;

  PecaEnderacamentoModel({
    required this.id_peca_enderecamento,
    required this.id_peca_estoque,
    required this.id_box,
    this.peca_estoque,
    required this.endereco,
    this.nomeFornecedor,
    this.descPiso
  });

  factory PecaEnderacamentoModel.fromJson(Map<String, dynamic> json) {
    return PecaEnderacamentoModel(
      id_peca_enderecamento: json['id_peca_enderecamento'],
      id_peca_estoque: json['id_peca_estoque'],
      id_box: json['id_box'],
      peca_estoque: json['estoque'] == null ? null : PecasEstoqueModel.fromJson(json['estoque']),
      endereco: json['endereco'],
      nomeFornecedor: json['fornecedor'],
      descPiso: json['piso'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id_peca_enderecamento'] = this.id_peca_enderecamento;
    data['id_peca_estoque'] = this.id_peca_estoque;
    data['id_box'] = this.id_box;

    return data;
  }


}