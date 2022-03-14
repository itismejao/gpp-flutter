import 'dart:convert';

import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:http/http.dart';

import 'package:gpp/src/models/FuncionalidadeModel.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/shared/exceptions/user_exception.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class UsuarioRepository {
  ApiService api = gppApi;

  String path = '/usuarios';

  Future<UsuarioModel> fetchUser(String id) async {
    Response response = await api.get('/user/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return UsuarioModel.fromJson(data.first);
    } else {
      throw UserException('Usuário não encontrado !');
    }
  }

  Future<List<UsuarioModel>> buscarTodos() async {
    Response response = await api.get(path);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<UsuarioModel> users = data
          .map<UsuarioModel>((data) => UsuarioModel.fromJson(data))
          .toList();
      return users;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<List<SubFuncionalidadeModel>> fetchSubFuncionalities(String id) async {
    Response response = await api.get('/user/itensfuncionalidades/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalidadeModel> subFuncionalities = data.first
          .map<SubFuncionalidadeModel>(
              (data) => SubFuncionalidadeModel.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      throw UserException(
          "Não foi encontrado itens de funcionalidades relacionado ao usuário !");
    }
  }

  Future<bool> updateUserSubFuncionalities(
      UsuarioModel user, List<SubFuncionalidadeModel> subFuncionalities) async {
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

  Future<List<FuncionalidadeModel>> buscarFuncionalidades(
      UsuarioModel user) async {
    Response response =
        await api.get(path + '/' + user.id.toString() + '/funcionalidades');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<FuncionalidadeModel> funcionalidades = data
          .map<FuncionalidadeModel>(
              (data) => FuncionalidadeModel.fromJson(data))
          .toList();

      return funcionalidades;
    } else {
      var error = json.decode(response.body)['error'];

      throw error;
    }
  }

  Future<bool> update(UsuarioModel user) async {
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
