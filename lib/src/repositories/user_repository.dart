import 'dart:convert';

import 'package:http/http.dart';

import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/shared/exceptions/user_exception.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class UserRepository {
  ApiService api;

  UserRepository({
    required this.api,
  });

  Future<List<UserModel>> fetchUser() async {
    Response response = await api.get('/user');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<UserModel> users = data.first
          .map<UserModel>((data) => UserModel.fromJson(data))
          .toList();
      return users;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw UserException(error);
    }
  }

  Future<List<SubFuncionalities>> fetchSubFuncionalities(UserModel user) async {
    Response response =
        await api.get('/user/itensfuncionalidades/' + user.uid.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalities> subFuncionalities = data.first
          .map<SubFuncionalities>((data) => SubFuncionalities.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw UserException(error);
    }
  }

  Future<bool> updateUserSubFuncionalities(
      UserModel user, List<SubFuncionalities> subFuncionalities) async {
    List<Map<String, dynamic>> dataSend = subFuncionalities
        .map((subFuncionalitie) => subFuncionalitie.toJson())
        .toList();

    Response response = await api.put(
        '/user/itensfuncionalidades/' + user.uid.toString(), dataSend);

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw UserException(error);
    }
  }
}
