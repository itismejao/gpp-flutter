import 'dart:convert';

import 'package:gpp/src/models/subfuncionalities_model.dart';
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
      throw UserException('Usuários não encontrados !');
    }
  }

  Future<List<SubFuncionalitiesModel>> fetchSubFuncionalities(
      UserModel user) async {
    Response response =
        await api.get('/user/itensfuncionalidades/' + user.id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalitiesModel> subFuncionalities = data.first
          .map<SubFuncionalitiesModel>(
              (data) => SubFuncionalitiesModel.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      throw UserException(
          "Não foi encontrado itens de funcionalidades relacionado ao usuário !");
    }
  }

  Future<bool> updateUserSubFuncionalities(
      UserModel user, List<SubFuncionalitiesModel> subFuncionalities) async {
    List<Map<String, dynamic>> dataSend = subFuncionalities
        .map((subFuncionalitie) => subFuncionalitie.toJson())
        .toList();

    Response response = await api.put(
        '/user/itensfuncionalidades/' + user.id.toString(), dataSend);

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw UserException(error);
    }
  }

  Future<List<FuncionalitieModel>> fetchFuncionalities(UserModel user) async {
    Response response =
        await api.get('/user/funcionalidades/' + user.id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<FuncionalitieModel> funcionalidades = data.first
          .map<FuncionalitieModel>((data) => FuncionalitieModel.fromJson(data))
          .toList();

      return funcionalidades;
    } else {
      throw UserException("Funcionalidades não encontradas !");
    }
  }

  Future<bool> update(UserModel user) async {
    print(jsonEncode(user.toJson()));
    Response response =
        await api.put('/user/' + user.id.toString(), user.toJson());
    print(response);
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw UserException(error);
    }
  }
}
