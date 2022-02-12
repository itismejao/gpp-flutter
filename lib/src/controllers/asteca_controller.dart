import 'package:flutter/material.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/models/documento_fiscal_model.dart';

import 'package:gpp/src/repositories/asteca_repository.dart';

class AstecaController {
  bool abrirDropDownButton = false;

  int step = 4;
  bool isOpenFilter = false;
  int pagina = 1;
  bool carregado = false;
  List<AstecaTipoPendenciaModel> astecaTipoPendencia = [
    AstecaTipoPendenciaModel(
        idTipoPendencia: 881, descricao: 'PEÇA SEPARADA NO BOX'),
    AstecaTipoPendenciaModel(
        idTipoPendencia: 651, descricao: 'PECA SOLICITADA AO FORNECEDOR')
  ];

  AstecaModel asteca = AstecaModel(
      documentoFiscal: DocumentoFiscalModel(),
      astecaTipoPendencia: AstecaTipoPendenciaModel(
          idTipoPendencia: 651, descricao: 'PECA SOLICITADA AO FORNECEDOR'));
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
