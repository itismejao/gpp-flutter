import 'package:flutter/material.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';

class DepartamentController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DepartamentRepository repository;
  List<DepartamentModel> departaments = [];
  List<SubFuncionalitiesModel> subFuncionalities = [];
  DepartamentEnum state = DepartamentEnum.notDepartament;

  DepartamentController({
    required this.repository,
  });

  Future<void> changeDepartament() async {
    departaments = await repository.fetchDepartament();
  }

  Future<bool> updateUserSubFuncionalities(DepartamentModel departament,
      List<SubFuncionalitiesModel> subFuncionalities) async {
    return await repository.updateDepartmentSubFuncionalities(
        departament, subFuncionalities);
  }

  Future<void> changeDepartamentSubFuncionalities(
      DepartamentModel departament) async {
    subFuncionalities = await repository.fetchSubFuncionalities(departament);
  }

  Future<bool> create(DepartamentModel departament) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    // formKey.currentState!.save();

    return await repository.create(departament);
  }

  Future<bool> delete(DepartamentModel departament) async {
    return await repository.delete(departament);
  }

  //Validação
  validateInput(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
  // List<UserModel> usersSearch = [];

  // UserEnum state = UserEnum.notUser;

  // Future<void> changeUser() async {
  //   users = await repository.fetchUser();
  // }

  // void search(String value) {
  //   usersSearch = users
  //       .where((user) =>
  //           (user.name!.toLowerCase().contains(value.toLowerCase()) ||
  //               user.uid!.toLowerCase().contains(value.toLowerCase())))
  //       .toList();
  // }

}
