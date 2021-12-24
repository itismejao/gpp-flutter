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
}
