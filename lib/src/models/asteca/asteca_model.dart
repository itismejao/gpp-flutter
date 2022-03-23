import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/models/asteca/asteca_end_cliente_model.dart';
import 'package:gpp/src/models/asteca/asteca_motivo_model.dart';
import 'package:gpp/src/models/asteca/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/models/documento_fiscal_model.dart';
import 'package:gpp/src/models/funcionario_model.dart';
import 'package:gpp/src/models/produto_model.dart';

class AstecaModel {
  int? idAsteca;
  AstecaMotivoModel? astecaMotivo;
  int? tipoAsteca; //Defini se é cliente ou estoque
  int? idFilialRegistro;
  String? observacao;
  String? defeitoEstadoProd;
  DateTime? dataEmissao;
  AstecaEndClienteModel? astecaEndCliente;
  DocumentoFiscalModel? documentoFiscal;
  List<ProdutoModel>? produto;
  FuncionarioModel? funcionario;
  PedidoSaidaModel? pedidoSaida;

  //Tabela pivot
  List<AstecaTipoPendenciaModel>? astecaTipoPendencias;

  AstecaModel({
    this.idAsteca,
    this.tipoAsteca,
    this.idFilialRegistro,
    this.observacao,
    this.defeitoEstadoProd,
    this.dataEmissao,
    this.astecaTipoPendencias,
    this.astecaEndCliente,
    this.astecaMotivo,
    this.documentoFiscal,
    this.produto,
    this.funcionario,
    this.pedidoSaida,
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
        funcionario: json['funcionario'] != null
            ? FuncionarioModel.fromJson(json['funcionario'].first)
            : null,
        astecaTipoPendencias: json['pendencia'] != null
            ? json['pendencia'].map<AstecaTipoPendenciaModel>((data) {
                return AstecaTipoPendenciaModel.fromJson(data);
              }).toList()
            : null,
        pedidoSaida: json['pedido_saida'] != null
            ? PedidoSaidaModel.fromJson(json['pedido_saida'])
            : null);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_asteca'] = this.idAsteca;
    data['tipo_asteca'] = this.tipoAsteca;
    data['id_filial_registro'] = this.idFilialRegistro;
    data['observacao'] = this.observacao;
    data['defeito_estado_prod'] = this.defeitoEstadoProd;
    data['data_emissao'] = this.dataEmissao.toString();
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