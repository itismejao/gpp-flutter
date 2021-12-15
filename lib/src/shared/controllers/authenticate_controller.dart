import 'dart:convert';

import 'package:gpp/src/shared/exceptions/user_exception.dart';
import 'package:gpp/src/shared/models/token_model.dart';
import 'package:gpp/src/shared/models/authenticate_model.dart';
import 'package:gpp/src/shared/services/api.dart';

class AuthenticateController {
  Future<AuthenticateModel> login(uid, password) async {
    try {
      var response =
          await api.post('/user/login', {'uid': uid, 'password': password});

      if (response.statusCode == 401) {
        var error = jsonDecode(response.body)['error'];

        throw UserNotFoundException(error);
      }

      return AuthenticateModel.fromJson(jsonDecode(response.body));
    } on UserNotFoundException {
      rethrow;
    }
  }

  Future<TokenModel> createToken(email, password) async {
    var response =
        await api.post('/user/token', {'email': email, 'password': password});

    try {
      if (response.statusCode == 401) {
        throw ("Usuário não possui token disponível");
      }
      return TokenModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      rethrow;
    }
  }
}
