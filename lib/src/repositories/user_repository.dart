import 'dart:convert';

import 'package:http/http.dart';

import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:gpp/src/shared/exceptions/user_exception.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class UserRepository {
  ApiService api;

  UserRepository({
    required this.api,
  });

  Future<List<UserModel>> fetchUser() async {
    try {
      Response response = await api.get('/user');

      if (response.statusCode == StatusCode.NOT_FOUND) {
        var error = jsonDecode(response.body)['error'];
        throw UserException(error);
      }

      var data = jsonDecode(response.body);

      List<UserModel> funcionalidades = data.first
          .map<UserModel>((data) => UserModel.fromJson(data))
          .toList();

      return funcionalidades;
    } on UserException {
      rethrow;
    }
  }
}
