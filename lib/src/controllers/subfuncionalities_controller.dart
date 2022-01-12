import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/subfuncionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/subfuncionalities_enum.dart';

class SubFuncionalitiesController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final SubFuncionalitiesRepository repository;

  List<SubFuncionalitiesModel> subFuncionalities = [];

  SubFuncionalitiesModel subFuncionalitie = SubFuncionalitiesModel();
  SubFuncionalitiesEnum state = SubFuncionalitiesEnum.notChange;
  // bool groupValue = false;

  SubFuncionalitiesController({required this.repository});

  Future<void> fetch(FuncionalitieModel funcionalitie) async {
    subFuncionalities = await repository.fetch(funcionalitie);
  }

  void setSubFuncionalitieName(value) {
    subFuncionalitie.name = value;
  }

  void setSubFuncionalitieIcon(value) {
    subFuncionalitie.icon = value;
  }

  void setSubFuncionalitieRoute(value) {
    subFuncionalitie.route = value;
  }

  void setSubFuncionalitieActive(value) {
    subFuncionalitie.active = value;
  }

  // //Validação
  validateInput(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<bool> create(FuncionalitieModel funcionalitie) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    return await repository.create(funcionalitie, subFuncionalitie);
  }

  Future<bool> update(SubFuncionalitiesModel subFuncionalitie) async {
    return await repository.update(subFuncionalitie);
  }

  Future<bool> delete(SubFuncionalitiesModel subFuncionalitie) async {
    return await repository.delete(subFuncionalitie);
  }
}
