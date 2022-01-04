import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class FuncionalitiesController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final FuncionalitiesRepository repository;
  List<FuncionalitieModel> funcionalities = [];
  FuncionalitieModel funcionalitie = FuncionalitieModel();
  FuncionalitiesEnum state = FuncionalitiesEnum.notChange;
  bool groupValue = false;

  FuncionalitiesController(this.repository);

  Future<void> fetch() async {
    funcionalities = await repository.fetch();
  }

  void setFuncionalitieName(value) {
    funcionalitie.name = value;
  }

  void setFuncionalitieIcon(value) {
    funcionalitie.icon = value;
  }

  void setFuncionalitieActive(value) {
    funcionalitie.active = value;
  }

  //Validação
  validateInput(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<bool> create() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    return await repository.create(funcionalitie);
  }

  Future<bool> update(FuncionalitieModel funcionalitie) async {
    return await repository.update(funcionalitie);
  }

  Future<bool> delete(FuncionalitieModel funcionalitie) async {
    return await repository.delete(funcionalitie);
  }
}
