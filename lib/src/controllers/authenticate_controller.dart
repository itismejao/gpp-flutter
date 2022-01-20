import 'package:flutter/material.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/authenticate_repository.dart';
import 'package:gpp/src/shared/enumeration/authenticate_enum.dart';

class AuthenticateController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool visiblePassword = false;

  late final AuthenticateRepository repository;
  AuthenticateEnum state = AuthenticateEnum.notLogged;

  AuthenticateController(this.repository);

  UserModel user = UserModel();

  setUserUID(int? uid) => user.uid = uid;

  setUserPassword(String? password) => user.password = password;

  validateInput(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<bool> login() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    formKey.currentState!.save();
    formKey.currentState!.reset();

    try {
      return await repository.doLogin(user);
    } catch (e) {
      rethrow;
    }
  }
}
