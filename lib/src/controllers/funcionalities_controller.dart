import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class FuncionalitiesController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final FuncionalitiesRepository repository =
      FuncionalitiesRepository(api: gppApi);
  List<FuncionalitieModel> funcionalities = [];
  FuncionalitieModel funcionalitie = FuncionalitieModel();
  FuncionalitiesEnum state = FuncionalitiesEnum.notChange;
  bool groupValue = false;

  FuncionalitiesController();

  Future<void> fetch(String id) async {
    funcionalitie = await repository.fetch(id);
  }

  Future<void> fetchAll() async {
    funcionalities = await repository.fetchAll();
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
  validate(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<bool> create() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    return await repository.create(funcionalitie);
  }

  Future<bool> update() async {
    return await repository.update(funcionalitie);
  }

  Future<bool> delete(FuncionalitieModel funcionalitie) async {
    return await repository.delete(funcionalitie);
  }
}
