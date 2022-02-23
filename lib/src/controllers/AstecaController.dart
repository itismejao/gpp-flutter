import 'package:flutter/material.dart';
import 'package:gpp/src/models/PaginaModel.dart';

import 'package:gpp/src/models/PedidoSaidaModel.dart';
import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/ProdutoPecaModel.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/models/documento_fiscal_model.dart';

import 'package:gpp/src/repositories/AstecaRepository.dart';
import 'package:gpp/src/repositories/PecaRepository.dart';
import 'package:gpp/src/repositories/PedidoRepository.dart';

class AstecaController {
  late PedidoRepository pedidoRepository = PedidoRepository();
  bool carregaProdutoPeca = false;
  late PecaRepository pecaRepository = PecaRepository();
  late List<ProdutoPecaModel> produtoPecas;

  DateTime? dataInicio;
  DateTime? dataFim;

  PedidoSaidaModel pedidoSaida = PedidoSaidaModel(
    itemsPedidoSaida: [],
    valorTotal: 0.0,
  );

  bool abrirDropDownButton = false;

  String? pendenciaFiltro;

  int step = 4;
  bool abrirFiltro = false;

  bool carregado = false;
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);
  late AstecaTipoPendenciaModel astecaTipoPendencia;
  List<AstecaTipoPendenciaModel> astecaTipoPendencias = [];
  List<AstecaTipoPendenciaModel> astecaTipoPendenciasBuscar = [];
  AstecaModel asteca = AstecaModel(
    documentoFiscal: DocumentoFiscalModel(),
  );
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  AstecaRepository repository = AstecaRepository();
  AstecaModel filtroAsteca = AstecaModel(
    documentoFiscal: DocumentoFiscalModel(),
  );
  List<AstecaModel> astecas = [];

  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // AstecaModel asteca = AstecaModel();

  // List<SubFuncionalitiesModel> subFuncionalities = [];
  // AstecaEnum state = AstecaEnum.notAsteca;

  // AstecaController();

  // Future<void> fetch(String id) async {
  //   asteca = await repository.fetch(id);
  // }

  // Future<void> fetchAll() async {
  //   astecas = await repository.fetchAll();
  // }

  // Future<bool> updateastecaSubFuncionalities() async {
  //   return await repository.updateDepartmentSubFuncionalities(
  //       asteca, subFuncionalities);
  // }

  // Future<void> changeAstecaSubFuncionalities(AstecaModel asteca) async {
  //   subFuncionalities = await repository.fetchSubFuncionalities(asteca);
  // }

  // Future<bool> create() async {
  //   if (formKey.currentState!.validate()) {
  //     return await repository.create(asteca);
  //   }

  //   return false;
  // }

  // Future<bool> update() async {
  //   return await repository.update(asteca);
  // }

  // Future<bool> delete(AstecaModel asteca) async {
  //   return await repository.delete(asteca);
  // }

  // validate(value) {
  //   if (value.isEmpty) {
  //     return 'Campo obrigatório';
  //   }
  //   return null;
  // }
}
