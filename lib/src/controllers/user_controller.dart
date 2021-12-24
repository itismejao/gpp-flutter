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
  UserEnum state = UserEnum.notUser;

  UserController({
    required this.repository,
  });

  Future<void> changeUser() async {
    users = await repository.fetchUser();
  }
}
