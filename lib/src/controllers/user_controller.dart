import 'package:flutter/cupertino.dart';

import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class UserController {
  UserRepository repository;
  List<UserModel> users = [];
  List<UserModel> usersSearch = [];
  List<SubFuncionalities> subFuncionalities = [];
  UserEnum state = UserEnum.notUser;

  UserController({
    required this.repository,
  });

  Future<void> changeUser() async {
    users = await repository.fetchUser();
  }

  Future<void> changeUserFuncionalities() async {
    UserModel user = UserModel();
    user.uid = "1";
    subFuncionalities = await repository.fetchSubFuncionalities(user);
  }

  void search(String value) {
    if (value.isNotEmpty) {
      usersSearch = users
          .where((user) =>
              (user.name!.toLowerCase().contains(value.toLowerCase()) ||
                  user.uid!.toLowerCase().contains(value.toLowerCase())))
          .toList();
    }
  }

  Future<bool> updateUserSubFuncionalities(
      List<SubFuncionalities> subFuncionalities) async {
    UserModel user = UserModel();
    user.uid = "1";

    return await repository.updateUserSubFuncionalities(
        user, subFuncionalities);
  }
}
