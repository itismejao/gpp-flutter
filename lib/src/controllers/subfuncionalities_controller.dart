import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/subfuncionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/subfuncionalities_enum.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class SubFuncionalitiesController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final SubFuncionalitiesRepository repository =
      SubFuncionalitiesRepository(api: gppApi);

  List<SubFuncionalitiesModel> subFuncionalities = [];

  SubFuncionalitiesModel subFuncionalitie = SubFuncionalitiesModel();
  SubFuncionalitiesEnum state = SubFuncionalitiesEnum.notChange;
  // bool groupValue = false;

  SubFuncionalitiesController();

  Future<void> fetch(String id) async {
    subFuncionalities = await repository.fetch(id);
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
  validate(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<bool> create(String id) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    return await repository.create(id, subFuncionalitie);
  }

  Future<bool> update(SubFuncionalitiesModel subFuncionalitie) async {
    return await repository.update(subFuncionalitie);
  }

  Future<bool> delete(SubFuncionalitiesModel subFuncionalitie) async {
    return await repository.delete(subFuncionalitie);
  }
}
