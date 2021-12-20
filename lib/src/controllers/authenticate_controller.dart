import 'package:flutter/material.dart';
import 'package:gpp/src/models/user_models.dart';
import 'package:gpp/src/repositories/authenticate_repository.dart';
import 'package:gpp/src/shared/enumeration/authenticate_enum.dart';

class AuthenticateController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late final AuthenticateRepository repository;
  AuthenticateEnum status = AuthenticateEnum.notLogged;

  AuthenticateController(this.repository);

  UserModel user = UserModel();

  setUserUID(String? uid) => user.uid = uid;

  setUserPassword(String? password) => user.password = password;

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
