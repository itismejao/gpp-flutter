import 'package:gpp/src/models/asteca_end_cliente_model.dart';
import 'package:gpp/src/models/asteca_motivo_model.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/models/documento_fiscal_model.dart';
import 'package:gpp/src/models/funcionario_model.dart';
import 'package:gpp/src/models/produto_model.dart';

class AstecaModel {
  dynamic idAsteca;
  int? tipoAsteca;
  int? idFilialRegistro;
  String? observacao;
  String? defeitoEstadoProd;
  DateTime? dataEmissao;
  List<AstecaTipoPendenciaModel>? astecaTipoPendencia;
  AstecaEndClienteModel? astecaEndCliente;
  AstecaMotivoModel? astecaMotivo;
  DocumentoFiscalModel? documentoFiscal;
  List<ProdutoModel>? produto;
  FuncionarioModel? funcionario;

  AstecaModel({
    this.idAsteca,
    this.tipoAsteca,
    this.idFilialRegistro,
    this.observacao,
    this.defeitoEstadoProd,
    this.dataEmissao,
    this.astecaTipoPendencia,
    this.astecaEndCliente,
    this.astecaMotivo,
    this.documentoFiscal,
    this.produto,
    this.funcionario,
  });

  factory AstecaModel.fromJson(Map<String, dynamic> json) {
    return AstecaModel(
        idAsteca: json['id_asteca'],
        tipoAsteca: json['tipo_asteca'],
        idFilialRegistro: json['id_filial_registro'],
        observacao: json['observacao'],
        defeitoEstadoProd: json['defeito_estado_prod'],
        dataEmissao: DateTime.parse(json['data_emissao']),
        astecaEndCliente: json['asteca_end_cliente'] != null
            ? AstecaEndClienteModel.fromJson(json['asteca_end_cliente'])
            : null,
        astecaMotivo: json['asteca_motivo'] != null
            ? AstecaMotivoModel.fromJson(json['asteca_motivo'])
            : null,
        documentoFiscal: json['documento_fiscal'] != null
            ? DocumentoFiscalModel.fromJson(json['documento_fiscal'])
            : null,
        produto: json['produto'] != null
            ? json['produto'].map<ProdutoModel>((data) {
                return ProdutoModel.fromJson(data);
              }).toList()
            : null,
        funcionario: FuncionarioModel.fromJson(json['funcionario'].first),
        astecaTipoPendencia: json['pendencia'] != null
            ? json['pendencia'].map<AstecaTipoPendenciaModel>((data) {
                return AstecaTipoPendenciaModel.fromJson(data);
              }).toList()
            : null);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_asteca'] = this.idAsteca;
    data['tipo_asteca'] = this.tipoAsteca;
    data['id_filial_registro'] = this.idFilialRegistro;
    data['observacao'] = this.observacao;
    data['defeito_estado_prod'] = this.defeitoEstadoProd;
    data['data_emissao'] = this.dataEmissao;
    if (this.astecaEndCliente != null) {
      data['asteca_end_cliente'] = this.astecaEndCliente!.toJson();
    }
    data['asteca_motivo'] = this.astecaMotivo;
    data['documento_fiscal'] = this.documentoFiscal;
    if (this.produto != null) {
      data['produto'] = this.produto!.map((v) => v.toJson()).toList();
    }
    if (this.funcionario != null) {
      data['funcionario'] = this.funcionario;
    }
    return data;
  }
}
