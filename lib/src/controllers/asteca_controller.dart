import 'package:flutter/material.dart';
import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/astecas_repository.dart';

import 'package:gpp/src/shared/enumeration/asteca_enum.dart';

class AstecaController {
  int step = 1;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AstecaRepository repository;
  AstecaModel asteca = AstecaModel();
  List<AstecaModel> astecas = [];
  List<SubFuncionalitiesModel> subFuncionalities = [];
  AstecaEnum state = AstecaEnum.notAsteca;

  AstecaController(
    this.repository,
  );

  Future<void> fetch(String id) async {
    asteca = await repository.fetch(id);
  }

  Future<void> fetchAll() async {
    astecas = await repository.fetchAll();
  }

  Future<bool> updateastecaSubFuncionalities() async {
    return await repository.updateDepartmentSubFuncionalities(
        asteca, subFuncionalities);
  }

  Future<void> changeAstecaSubFuncionalities(AstecaModel asteca) async {
    subFuncionalities = await repository.fetchSubFuncionalities(asteca);
  }

  Future<bool> create() async {
    if (formKey.currentState!.validate()) {
      return await repository.create(asteca);
    }

    return false;
  }

  Future<bool> update() async {
    return await repository.update(asteca);
  }

  Future<bool> delete(AstecaModel asteca) async {
    return await repository.delete(asteca);
  }

  validate(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
