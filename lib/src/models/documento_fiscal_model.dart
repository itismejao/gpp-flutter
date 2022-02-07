import 'package:gpp/src/models/item_doc_fiscal_model.dart';

class DocumentoFiscalModel {
  int? idDocumentoFiscal;
  int? idFilialSaida;
  int? idFilialVenda;
  String? nome;
  dynamic cpfCnpj;
  int? numDocFiscal;
  String? serieDocFiscal;
  DateTime? dataEmissao;
  ItemDocFiscalModel? itemDocFiscal;

  DocumentoFiscalModel(
      {this.idDocumentoFiscal,
      this.idFilialSaida,
      this.idFilialVenda,
      this.nome,
      this.cpfCnpj,
      this.numDocFiscal,
      this.serieDocFiscal,
      this.dataEmissao,
      this.itemDocFiscal});

  factory DocumentoFiscalModel.fromJson(Map<String, dynamic> json) {
    return DocumentoFiscalModel(
        idDocumentoFiscal: json['id_documento_fiscal'],
        idFilialSaida: json['id_filial_saida'],
        idFilialVenda: json['id_filial_venda'],
        nome: json['nome'],
        cpfCnpj: json['cpf_cnpj'],
        numDocFiscal: json['num_doc_fiscal'],
        serieDocFiscal: json['serie_doc_fiscal'],
        dataEmissao: DateTime.parse(json['data_emissao']),
        itemDocFiscal: json['item_doc_fiscal'] != null
            ? new ItemDocFiscalModel.fromJson(json['item_doc_fiscal'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_documento_fiscal'] = this.idDocumentoFiscal;
    data['id_filial_saida'] = this.idFilialSaida;
    data['id_filial_venda'] = this.idFilialVenda;
    data['nome'] = this.nome;
    data['cpf_cnpj'] = this.cpfCnpj;
    data['num_doc_fiscal'] = this.numDocFiscal;
    data['serie_doc_fiscal'] = this.serieDocFiscal;
    data['data_emissao'] = this.dataEmissao;
    if (this.itemDocFiscal != null) {
      data['item_doc_fiscal'] = this.itemDocFiscal!.toJson();
    }
    return data;
  }
}
