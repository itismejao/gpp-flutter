import 'package:flutter/material.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';

class DepartamentController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DepartamentRepository repository;
  List<DepartamentModel> departaments = [];
  List<SubFuncionalitiesModel> subFuncionalities = [];
  DepartamentEnum state = DepartamentEnum.notDepartament;

  DepartamentController(
    this.repository,
  );

  Future<void> fetchAll() async {
    departaments = await repository.fetchAll();
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

  Future<bool> insertOrUpdate(DepartamentModel departament) async {
    if (departament.id == null) {
      return create(departament);
    } else {
      return update(departament);
    }
  }

  Future<bool> create(DepartamentModel departament) async {
    if (formKey.currentState!.validate()) {
      return await repository.create(departament);
    }

    return false;
  }

  Future<bool> update(DepartamentModel departament) async {
    return await repository.update(departament);
  }

  Future<bool> delete(DepartamentModel departament) async {
    return await repository.delete(departament);
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
